class Session
  include ActiveModel::Validations
  attr_accessor :login
  attr_accessor :password

  validate :login_invalid, :banned

  def login_invalid
    user = User.find_by(login: login)
    if !user || user.password != password
      errors.add(:login, :incorrect, message: 'incorrect data')
    end
  end

  def banned
    user = User.find_by(login: login)
    if user && user.ban && (user.ban.permanent? || user.ban.expires_at > Time.now)
      errors.add(:login, :banned, message: "you're banned")
    end
  end
end
