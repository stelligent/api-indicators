class Indicator < ActiveRecord::Base
  attr_accessible :service_id, :project_id, :has_page

  belongs_to :service
  belongs_to :project
  has_many :events, dependent: :destroy
  has_many :statuses, through: :events

  default_scope order(:project_id, :service_id)

  after_create :set_on_create

  def name
    "#{project.name}: #{service.name}"
  end

  # Gets current status of indicator.
  def current_state
    events.first
  end

  def history_size
    events.count
  end

  def get_history size = 10
    events.limit(size)
  end

  def set status, message = nil
    events.create(
      status_id: Status.find_or_create_by_name(status).id,
      message: message
      )
  end

  def api_return_format
    {
      id: self.id,
      project: self.project.api_return_format,
      service: self.service.api_return_format,
      current_event: self.current_state.api_return_format,
      has_page: self.has_page
    }
  end

private

  # Used in after_create callback.
  # Sets default state of every new indicator.
  def set_on_create
    set Status::DEFAULT, "Initialization"
  end
end
