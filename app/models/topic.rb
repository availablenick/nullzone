class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :section
end
