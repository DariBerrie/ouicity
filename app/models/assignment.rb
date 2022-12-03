class Assignment < ApplicationRecord
  belongs_to :worker, class_name: 'User'
  belongs_to :alert
end
