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
FactoryBot.define do
  factory :user_drink do
    user { create(:user) }
    drink { create(:drink) }
  end
end
