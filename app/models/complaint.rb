class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :complainable, polymorphic: true

  validates :complainee, presence: true
end
