class Topico < ApplicationRecord
  belongs_to :usuario
  has_many :posts, dependent: :destroy

  validates :titulo, :mensagem, presence: true
end
