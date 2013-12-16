class EventSerializer < ActiveModel::Serializer
  attributes :id, :time, :message

  embed :ids, include: true

  has_one :status

  def time
    object.created_at
  end
end
