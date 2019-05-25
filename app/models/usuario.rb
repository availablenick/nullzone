class Usuario < ApplicationRecord
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  has_many :topicos, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :login, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }
end
