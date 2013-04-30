class IndicatorState < ActiveRecord::Base
  DEFAULT = "green"

  attr_accessible :name

  has_many :events, foreign_key: :indicator_state_id

  validates :name, presence: true, uniqueness: true

  def self.default
    find_by_name(DEFAULT)
  end
end
