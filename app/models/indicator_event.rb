class IndicatorEvent < ActiveRecord::Base
  attr_accessible :description, :indicator_id, :indicator_state_id

  belongs_to :indicator
  belongs_to :state, class_name: "IndicatorState", foreign_key: :indicator_state_id

  default_scope order("created_at")
  scope :desc, order("created_at DESC")
end
