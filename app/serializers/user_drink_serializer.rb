class UserDrinkSerializer < ActiveModel::Serializer
  attributes :id, :drink_id, :name

  def name
    object.drink.name
  end
end
