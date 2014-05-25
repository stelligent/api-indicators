class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :users, :projects

  embed :ids
end
