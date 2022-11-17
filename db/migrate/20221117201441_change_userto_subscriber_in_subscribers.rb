class ChangeUsertoSubscriberInSubscribers < ActiveRecord::Migration[7.0]
  def change
    rename_column :subscribers, :user_id, :subscriber_id
  end
end
