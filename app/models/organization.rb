class Organization < ActiveRecord::Base
  attr_accessible :name

  has_many :users
  has_and_belongs_to_many :projects

  validates :name, presence: true, uniqueness: true
end
