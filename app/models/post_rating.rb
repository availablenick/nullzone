class PostRating < ApplicationRecord
  belongs_to :post
  belongs_to :usuario

  validates :value, presence: true
end
