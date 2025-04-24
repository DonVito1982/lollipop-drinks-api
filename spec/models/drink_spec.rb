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
require 'rails_helper'

RSpec.describe Drink, type: :model do
  context "Drink creation" do
    it "Checks drink creation" do
      expect {
        Drink.create(name: "Some drink", serv_count: 2, serv_caffeine: 65.5)
      }.to change { Drink.count }.by(1)
    end

    it "checks missing serving count" do
      expect {
        Drink.create(name: "Some drink", serv_caffeine: 26)
      }.to raise_error(ActiveRecord::NotNullViolation)
    end

    it "checks missing serving caffeine" do
      expect {
        Drink.create(name: "Some drink", serv_count: 2)
      }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
