class Round < ActiveRecord::Base
  has_many :rounds_users
  has_many :users,  through: :rounds_users
end
