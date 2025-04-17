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
