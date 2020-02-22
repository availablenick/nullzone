class Section < ApplicationRecord
  has_many :topics, dependent: :destroy

  validates :name, :description, presence: true
end
