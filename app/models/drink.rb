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
class Drink < ApplicationRecord
  has_many :user_drinks

  def self.caffeine_list
    all.map { |drink| { id: drink.id, mg: drink.serv_count * drink.serv_caffeine } }
  end
end
