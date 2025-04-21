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
require 'rails_helper'

RSpec.describe UserDrink, type: :model do
  let(:user) { create(:user) }
  let(:drink) { create(:drink) }

  it "selects relevant drinks" do
    user_drinks = user.user_drinks.count
    create(:user_drink, user: user, drink: drink)
    travel_to(36.hours.ago) do
      create(:user_drink, user: user, drink: drink)
    end

    expect(UserDrink.recent_drinks(user).count).to eq user_drinks + 1
  end
end
