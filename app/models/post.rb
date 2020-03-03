class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  has_many :complaints, as: :complainable
  has_many :ratings, dependent: :destroy

  validates :message, presence: true
end
