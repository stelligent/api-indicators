class IndicatorSerializer < ActiveModel::Serializer
  attributes :id, :current_event, :has_page

  embed :ids, include: true

  has_one :project
  has_one :service
end
