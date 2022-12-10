class ChangeAssignmentsToAlertsInSubscribers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :subscribers, :assignment, foreign_key: true
    add_reference :subscribers, :alert, foreign_key: true
  end
end
