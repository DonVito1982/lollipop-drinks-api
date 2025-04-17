FactoryBot.define do
  factory :drink do
    name { Faker::Beer.brand }
    serv_count { Faker::Number.between(from: 1, to: 4) }
    serv_caffeine { Faker::Number.decimal(l_digits: 2) }
  end
end
