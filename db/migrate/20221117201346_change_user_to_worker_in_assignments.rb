class ChangeUserToWorkerInAssignments < ActiveRecord::Migration[7.0]
  def change
    rename_column :assignments, :user_id, :worker_id
  end
end
