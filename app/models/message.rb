class Message < ApplicationRecord
  belongs_to :assignment
  belongs_to :user
  validates :content, presence: true
end
