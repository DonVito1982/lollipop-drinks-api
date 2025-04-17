FactoryBot.define do
  factory :user_drink do
    user { create(:user) }
    drink { create(:drink) }
  end
end
