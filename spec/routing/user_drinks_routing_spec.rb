require "rails_helper"

RSpec.describe UserDrinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_drinks").to route_to("user_drinks#index")
    end

    it "routes to #create" do
      expect(post: "/user_drinks").to route_to("user_drinks#create")
    end
  end
end
