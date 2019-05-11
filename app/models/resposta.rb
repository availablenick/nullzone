class Resposta < ApplicationRecord
  belongs_to :topico
  belongs_to :usuario
end
