class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :organization_id, :admin

  has_secure_password

  belongs_to :organization

  before_create :generate_api_token

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :password, if: :validate_password?
  validates_presence_of :organization_id, unless: :admin?

  def admin?
    admin
  end

  private

  def generate_api_token
    begin
      self.api_key = SecureRandom.hex
    end while User.exists?(api_key: api_key)
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end
end
