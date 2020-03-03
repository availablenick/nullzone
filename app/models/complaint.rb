class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :complainable, polymorphic: true

  validates :which_type, :complainee, presence: true
end
