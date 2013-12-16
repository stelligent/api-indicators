class Project < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :indicators, dependent: :destroy
  has_many :events, through: :indicators

  validates :name, presence: true, uniqueness: true

  after_create :create_indicators

private

  # Used in after_create callback.
  # Creates indicators of each service for newly created project.
  def create_indicators
    Service.all.each do |type|
      indicators.create(service_id: type.id)
    end
  end
end
