class Organization < ActiveRecord::Base
  attr_accessible :name, :project_ids, :service_ids, :user_ids

  has_many :users, dependent: :destroy
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :services

  validates :name, presence: true, uniqueness: true
end
