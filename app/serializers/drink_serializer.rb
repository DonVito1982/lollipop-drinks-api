# == Schema Information
#
# Table name: drinks
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  serv_caffeine :decimal(, )      not null
#  serv_count    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :serv_caffeine, :serv_count
end
