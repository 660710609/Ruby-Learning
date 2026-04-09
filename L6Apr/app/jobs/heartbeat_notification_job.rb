# app/jobs/heartbeat_notification_job.rb
class HeartbeatNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    pubsub = ActionCable.server.pubsub
    channel_name = "notifications_user_#{user_id}"

    user = User.find_by(id: user_id)

    if user && user.auth_token.present?
      ActionCable.server.broadcast(
        channel_name,
        { message: "Server Heartbeat to #{user.email}", time: Time.now.to_s }
      )

      HeartbeatNotificationJob.set(wait: 5.seconds).perform_later(user_id)
    else
      puts "--- [Job] Stopping heartbeat for User #{user_id} (User logged out) ---"
    end
  end
end
