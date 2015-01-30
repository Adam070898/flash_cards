class User < ActiveRecord::Base
  validates :email, uniqueness: true
  has_many :rounds
end
