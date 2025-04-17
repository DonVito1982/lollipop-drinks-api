require "rails_helper"

RSpec.describe UserDrinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/me").to route_to("users#me")
    end

    it "routes to #create" do
      expect(post: "/users").to route_to("users#create")
    end
  end
end
