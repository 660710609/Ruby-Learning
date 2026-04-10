class AddHeartbeatLastSentAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :heartbeat_last_sent_at, :datetime
  end
end
