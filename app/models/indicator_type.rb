class IndicatorType < ActiveRecord::Base
  attr_accessible :name

  has_many :indicators, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :create_indicators

  private

  # Used in after_create callback.
  # Creates indicators of newly created type for each project.
  def create_indicators
    Project.all.each do |project|
      indicators.create(project_id: project.id)
    end
  end
end
