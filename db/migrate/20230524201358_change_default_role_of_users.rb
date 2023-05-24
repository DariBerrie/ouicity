class ChangeDefaultRoleOfUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :role, 0
  end
end
