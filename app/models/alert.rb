class Alert < ApplicationRecord
  belongs_to :user

  validates :title, :description, :category, :address, :upvotes, :status, presence: true
  validates :description, length: { in: 30..300,
                                    too_long: "%{count} characters is the maximum allowed",
                                    too_short: "%{count} characters is the minimum required" }

  # These statuses are placeholders until we have a better idea
  # of what they should be.
  enum status: {
    unassigned: 0,
    in_progress: 1,
    resolved: 2
  }
end
