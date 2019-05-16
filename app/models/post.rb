class Post < ApplicationRecord
  belongs_to :topico
  belongs_to :usuario

  validates :mensagem, length: { minimum: 1,
    too_short: "Mensagem deve ter pelo menos 1 caractere." }
end
