class ChangeAssignmentsToAlertsInSubscribers < ActiveRecord::Migration[7.0]
  # This migration is causing issues since there was no previous seen migration adding
  # assignments to subscribers.
  # def change
  #   remove_reference :subscribers, :assignment, foreign_key: true
  #   add_reference :subscribers, :alert, foreign_key: true
  # end
end
