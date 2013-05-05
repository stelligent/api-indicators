class Service < ActiveRecord::Base
  attr_accessible :name

  has_many :indicators, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :create_indicators

  def api_return_format
    {
      id: self.id,
      name: self.name
    }
  end

  private

  # Used in after_create callback.
  # Creates indicators of newly created service for each project.
  def create_indicators
    Project.all.each do |project|
      indicators.create(project_id: project.id)
    end
  end
end
