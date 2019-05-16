class Usuario < ApplicationRecord
  has_many :topicos
  has_many :respostas

  validates :nome, presence: true, uniqueness: true
  validates :senha, presence: true
end
