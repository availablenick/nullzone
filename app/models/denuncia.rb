class Denuncia < ApplicationRecord
  belongs_to :post

  validates :denunciador, :denunciado, presence: true
end
