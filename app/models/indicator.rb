class Indicator < ActiveRecord::Base
  attr_accessible :indicator_type_id, :project_id

  belongs_to :type, class_name: "IndicatorType", foreign_key: :indicator_type_id
  belongs_to :project
  has_many :events, class_name: "IndicatorEvent", dependent: :destroy

  after_create :set_on_create

  def name
    "#{project.name} - #{type.name}"
  end

  # Gets current state of indicator.
  def current_state
    events.last.state
  end

  def history size = 10
    events.desc.limit(size)
  end

  def set state, description = nil
    events.create(
      indicator_state_id: IndicatorState.find_by_name(state).id,
      description: description
      )
  end

  private

  # Used in after_create callback.
  # Sets default state of every new indicator.
  def set_on_create
    IndicatorState.create(name: IndicatorState::DEFAULT) unless IndicatorState.default
    set IndicatorState::DEFAULT
  end
end
