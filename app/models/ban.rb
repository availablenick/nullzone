class Ban < ApplicationRecord
  belongs_to :user

  validates :reason, presence: true
  validates :expires_at, presence: true, unless: Proc.new { |ban| ban.permanent? }
end
