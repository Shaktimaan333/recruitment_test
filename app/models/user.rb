class User < ActiveRecord::Base
  has_many :miscs
  has_many :sheets
  has_many :scores
  has_many :attempts
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: {maximum: 50}, format: {with: /\A[^0-9`!@#\$%\^&*+_=]+\z/}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }, allow_blank: true
	validates :mobileno, length: { minimum: 7, maximum: 12 }, :numericality => {:only_integer => true}
	validates :classten, length: {maximum: 5}
	validates :classtwelve, length: {maximum: 5}
	validates :achievements, length: {maximum: 500}
	validates :experience, length: {maximum: 500}
	validates :projects, length: {maximum: 300}
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
  end
  def User.new_token
  	SecureRandom.urlsafe_base64
  end
  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  def forget
  	update_attribute(:remember_digest, nil)
  end
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  private
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
