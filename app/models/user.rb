class User < ApplicationRecord
  has_many :complaints, dependent: :nullify
  has_many :posts, dependent: :nullify
  has_many :ratings, dependent: :nullify
  has_many :topics, dependent: :nullify

  has_one :ban, dependent: :destroy

  has_one_attached :avatar

  validates :login, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
end
