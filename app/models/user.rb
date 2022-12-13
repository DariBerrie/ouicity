class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_default_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :alerts
  has_many :assignments
  has_many :messages
  has_many :chat_messages
  has_many :subscribers
  has_many :notifications, as: :recipient, dependent: :destroy

  enum role: { resident: 0, worker: 1 }

  def set_default_role
    self.role = 0
  end
  acts_as_voter
end
