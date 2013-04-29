class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :indicators, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_create :create_indicators

  private

  # Used in after_create callback.
  # Creates indicators of each type for newly created project.
  def create_indicators
    IndicatorType.all.each do |type|
      indicators.create(indicator_type_id: type.id)
    end
  end
end
