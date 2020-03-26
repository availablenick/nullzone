class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :section
  
  has_many :complaints, as: :complainable, dependent: :nullify
  has_many :posts, dependent: :destroy

  validates :title, :message, presence: true

  before_save :set_default
  before_update :set_default

  def set_default
    self.locked ||= false
    self.pinned ||= false
  end
end
