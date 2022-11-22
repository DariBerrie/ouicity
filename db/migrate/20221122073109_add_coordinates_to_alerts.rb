class AddCoordinatesToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :latitude, :float
    add_column :alerts, :longitude, :float
  end
end
