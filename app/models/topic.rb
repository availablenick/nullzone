class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :section
  
  has_many :complaints
  has_many :posts, dependent: :destroy

  validates :titulo, :mensagem, presence: true
end
