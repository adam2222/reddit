class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  attr_reader :password

  validates :session_token, :username, uniqueness: true
  validates :session_token, :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :subs,
    class_name: 'Sub',
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many(
    :posts,
    class_name: 'Post',
    foreign_key: :author_id,
    primary_key: :id
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    if user && user.is_password?(password)
      user
    else
      nil
    end

  end

  private

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
