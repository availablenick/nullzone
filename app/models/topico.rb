class Topico < ApplicationRecord
  belongs_to :usuario
  has_many :respostas
end
