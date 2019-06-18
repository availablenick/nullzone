class Post < ApplicationRecord
  belongs_to :topico
  belongs_to :usuario

  validates :mensagem, presence: true
end
