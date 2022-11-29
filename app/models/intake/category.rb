module Intake
  class Category
    include ActiveModel::Model
    attr_accessor :category
    validates :category, presence: true
  end
end
