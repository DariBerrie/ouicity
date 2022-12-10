class Subscriber < ApplicationRecord
  belongs_to :subscriber, class_name: 'User'
  belongs_to :alert
end
