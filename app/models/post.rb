class Post < ApplicationRecord
  belongs_to :topico
  belongs_to :usuario
  has_many :denunciations

  validates :mensagem, presence: true
end
