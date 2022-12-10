class Alert < ApplicationRecord
  # belongs_to :user
  belongs_to :creator, class_name: 'User'
  has_one :assignment
  has_many :subscribers

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  validates :title, :description, :category, :address, :upvotes, :status, presence: true
  validates :description, length: { in: 30..300,
                                    too_long: "%{count} characters is the maximum allowed",
                                    too_short: "%{count} characters is the minimum required" }

  acts_as_votable

  include PgSearch::Model
  pg_search_scope :search_by_everything,
                  against: %i[title description category address],
                  using: {
                    tsearch: { prefix: true }
                  }

  # These statuses are placeholders until we have a better idea
  # of what they should be.
  enum status: {
    submitted: 0,
    in_progress: 1,
    resolved: 2
  }
  has_many_attached :photos

  def assigned?
    return self.assignment
  end
end
