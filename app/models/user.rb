class User < ActiveRecord::Base
  validates :email, uniqueness: true
  has_many :rounds_users
  has_many :rounds,  through: :rounds_users
  # Remember to create a migration!
end
