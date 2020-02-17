class User < ApplicationRecord
  has_many :complaints
  has_many :posts
  has_many :ratings, dependent: :destroy
  has_many :topics

  validates :login, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }
end
