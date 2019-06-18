class Post < ApplicationRecord
  belongs_to :topico
  belongs_to :usuario
  has_many :denuncias, dependent: :destroy

  validates :mensagem, presence: true
end
