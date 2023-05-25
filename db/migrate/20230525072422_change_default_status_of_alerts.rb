class ChangeDefaultStatusOfAlerts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :alerts, :status, 0
  end
end
