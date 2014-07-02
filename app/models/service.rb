class Service < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :indicators, dependent: :destroy
  has_many :events, through: :indicators
  has_and_belongs_to_many :organizations

  validates :name, presence: true, uniqueness: true

  after_create :create_indicators

  def api_return_format
    {
      id: self.id,
      name: self.name,
      description: self.description || ""
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
