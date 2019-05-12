class Topico < ApplicationRecord
  belongs_to :usuario
  has_many :posts

  validates :titulo, presence: true
end
