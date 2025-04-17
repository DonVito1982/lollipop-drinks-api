require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    let(:url) { "/users" }
    context "When creating users" do
      let(:user_params) do
        {
          username: "some_username",
          password: "secret%23",
          first_name: "David",
          last_name: "Beckham"
        }
      end

      it "Creates user" do
        expect {
          post url, params: user_params
        }.to change { User.count }.by(1)
      end
    end
  end
end
