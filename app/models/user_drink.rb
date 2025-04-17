class UserDrink < ApplicationRecord
  belongs_to :user
  belongs_to :drink

  scope :recent_drinks, lambda { |user| where(user: user)
    .where("created_at > ?", 1.day.ago)
  }

  def self.recent_caffeine(user)
    recent_drinks(user).reduce(0) do |sum, user_drink|
      sum += user_drink.drink.serv_count * user_drink.drink.serv_caffeine
    end
  end
end
