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
FactoryBot.define do
  factory :drink do
    name { Faker::Beer.brand }
    serv_count { Faker::Number.between(from: 1, to: 4) }
    serv_caffeine { Faker::Number.decimal(l_digits: 2) }
  end
end
