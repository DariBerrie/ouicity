class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :alerts
  has_many :assignments
  has_many :messages

  validates :email, :first_name, :last_name, :address, :role, presence: true

  enum role: { resident: 0, worker: 1 }
end
