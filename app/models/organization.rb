class Organization < ActiveRecord::Base
  attr_accessible :name, :project_ids, :user_ids

  has_many :users, dependent: :destroy
  has_and_belongs_to_many :projects

  validates :name, presence: true, uniqueness: true
end
