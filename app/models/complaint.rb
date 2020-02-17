class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :topic
end
