# == Schema Information
#
# Table name: user_drinks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  drink_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_drinks_on_drink_id  (drink_id)
#  index_user_drinks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (drink_id => drinks.id)
#  fk_rails_...  (user_id => users.id)
#
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
