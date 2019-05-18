class Usuario < ApplicationRecord
  has_many :topicos, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :nome, presence: true, uniqueness: true
  validates :senha, length: { minimum: 5 }
end
