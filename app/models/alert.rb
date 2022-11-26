class Alert < ApplicationRecord
  # belongs_to :user
  attr_writer :current_step
  belongs_to :creator, class_name: 'User'

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates_presence_of :category, :if => lambda { |o| o.current_step == "category" }
  validates_presence_of :title, :category, :address, :if => lambda { |o| o.current_step == "details" }

  # validates :title, :description, :category, :address, :upvotes, :status, presence: true
  # validates :description, length: { in: 30..300,
  #                                   too_long: "%{count} characters is the maximum allowed",
  #                                   too_short: "%{count} characters is the minimum required" }

  # These statuses are placeholders until we have a better idea
  # of what they should be.
  enum status: {
    unassigned: 0,
    in_progress: 1,
    resolved: 2
  }
  has_many_attached :photos


  def current_step
    @current_step || steps.first
  end

  def steps
    ['category', 'details', 'confirm']
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end
end
