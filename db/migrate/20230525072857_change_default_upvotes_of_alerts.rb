class ChangeDefaultUpvotesOfAlerts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :alerts, :upvotes, 0
  end
end
