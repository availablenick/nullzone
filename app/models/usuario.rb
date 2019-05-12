class Usuario < ApplicationRecord
  has_many :topicos
  has_many :respostas

  validates :nome, :senha, presence: true
end
