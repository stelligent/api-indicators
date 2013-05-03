class ApiKey < ActiveRecord::Base
  require 'securerandom'
  before_create :generate_api_token

  private

  def generate_api_token
    begin
      self.access_token = SecureRandom.hex
    end while ApiKey.exists?(access_token: access_token)
  end
end
