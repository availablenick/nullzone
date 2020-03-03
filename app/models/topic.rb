class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :section
  
  has_many :complaints, as: :complainable, dependent: :nullify
  has_many :posts, dependent: :destroy

  validates :title, :message, presence: true
end
