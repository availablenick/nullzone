class Topico < ApplicationRecord
  belongs_to :usuario
  has_many :posts, dependent: :destroy
  has_one_attached :arquivo

  validates :titulo, :mensagem, presence: true
end
