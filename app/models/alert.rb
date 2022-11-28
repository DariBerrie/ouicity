class Alert < ApplicationRecord
  # belongs_to :user
  belongs_to :creator, class_name: 'User'

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


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
  has_many_attached :photos
end
