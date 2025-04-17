class Drink < ApplicationRecord
  has_many :user_drinks

  def self.caffeine_list
    all.map { |drink| { id: drink.id, mg: drink.serv_count * drink.serv_caffeine } }
  end
end
