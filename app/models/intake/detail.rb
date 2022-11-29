module Intake
  class Detail
    include ActiveModel::Model
    attr_accessor :title, :description, :address, :photos
    validates :title, :description, :address, presence: true
    validates :description, length: { in: 30..300,
      too_long: "%{count} characters is the maximum allowed",
      too_short: "%{count} characters is the minimum required" }
  end
end
