# app/jobs/heartbeat_notification_job.rb
class HeartbeatNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)

    return unless user && user.auth_token.present?

    if user.heartbeat_last_sent_at && user.heartbeat_last_sent_at > 4.seconds.ago
      puts "--- [Job] Duplicate detected for User #{user_id}, stopping this duplicate thread ---"
      return
    end

    user.update_column(:heartbeat_last_sent_at, Time.current)

    channel_name = "notifications_user_#{user_id}"
    ActionCable.server.broadcast(
      channel_name,
      {
        message: "Server Heartbeat to #{user.email}",
        time: Time.current.strftime("%H:%M:%S")
      }
    )

    HeartbeatNotificationJob.set(wait: 5.seconds).perform_later(user_id)
  end
end
