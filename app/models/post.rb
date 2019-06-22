class Post < ApplicationRecord
  belongs_to :topico
  belongs_to :usuario
  has_one_attached :arquivo

  validates :mensagem, presence: true
end
