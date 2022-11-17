class ChangeUserToWorkerInMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :user_id, :worker_id
  end
end
