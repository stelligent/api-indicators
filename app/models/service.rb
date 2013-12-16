class Service < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :indicators, dependent: :destroy
  has_many :events, through: :indicators

  validates :name, presence: true, uniqueness: true

  after_create :create_indicators

  private

  # Used in after_create callback.
  # Creates indicators of newly created service for each project.
  def create_indicators
    Project.all.each do |project|
      indicators.create(project_id: project.id)
    end
  end
end
