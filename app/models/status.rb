class Status < ActiveRecord::Base
  DEFAULT = "green"

  attr_accessible :name

  has_many :events

  validates :name, presence: true, uniqueness: true

  def self.default
    find_by_name(DEFAULT)
  end
end
