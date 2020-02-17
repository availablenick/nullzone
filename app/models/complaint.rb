class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :topic

  validates :complainee, :type, presence: true
end
