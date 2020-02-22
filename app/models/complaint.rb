class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :topic, optional: true

  validates :which_type, :complainee, presence: true
end
