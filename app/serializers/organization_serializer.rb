class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :users, :projects, :services

  embed :ids
end
