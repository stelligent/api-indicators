class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin

  has_one :organization

  embed :ids
end
