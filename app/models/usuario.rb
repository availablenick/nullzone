class Usuario < ApplicationRecord
  has_many :topicos
  has_many :respostas
end
