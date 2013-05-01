class Indicator < ActiveRecord::Base
  attr_accessible :service_id, :project_id

  belongs_to :service
  belongs_to :project
  has_many :events, dependent: :destroy

  after_create :set_on_create

  def name
    "#{project.name} - #{type.name}"
  end

  # Gets current status of indicator.
  def current_status
    events.last.status
  end

  def history size = 10
    events.desc.limit(size)
  end

  def set state, message = nil
    events.create(
      status_id: Status.find_by_name(state).id,
      message: message
      )
  end

  private

  # Used in after_create callback.
  # Sets default state of every new indicator.
  def set_on_create
    Status.create(name: Status::DEFAULT) unless Status.default
    set Status::DEFAULT
  end
end
