class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :serv_caffeine, :serv_count
end
