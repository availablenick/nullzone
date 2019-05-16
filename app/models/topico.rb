class Topico < ApplicationRecord
  belongs_to :usuario
  has_many :posts

  validates :titulo, length: { minimum: 1,
    too_short: "Título deve ter pelo menos 1 caractere."}
  validates :mensagem, length: { minimum: 1,
      too_short: "Mensagem deve ter pelo menos 1 caractere."}
end
