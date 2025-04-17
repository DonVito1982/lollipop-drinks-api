require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /caffeine-count" do
    let(:url) { "/caffeine-count" }

    context "With an authenticated request" do
      let(:user) { create(:user) }
      let(:drink1) { create(:drink) }
      let(:drink2) { create(:drink) }
      let(:parsed_body) { ActiveSupport::JSON.decode(response.body) }

      it "returns the total caffeine amount" do
        create(:user_drink, user: user, drink: drink1)
        create(:user_drink, user: user, drink: drink2)
        get url, headers: authenticated_header(user)
        expect(response).to have_http_status :ok
        total_caffeine = drink1.serv_count * drink1.serv_caffeine +
          drink2.serv_count * drink2.serv_caffeine
        expect(parsed_body).to include("recent_caffeine")
        expect(parsed_body["recent_caffeine"].to_f)
          .to be_within(0.001)
          .of(total_caffeine)
      end
    end
  end

  describe "POST /users" do
    let(:url) { "/users" }
    context "When creating users" do
      let(:user_params) do
        {
          username: Faker::Internet.username,
          password: "secret%23",
          first_name: "David",
          last_name: "Beckham"
        }
      end
      let(:parsed_body) { ActiveSupport::JSON.decode(response.body).symbolize_keys }

      it "Creates user" do
        expect {
          post url, params: user_params
        }.to change { User.count }.by(1)
      end

      it "responds with 201" do
        post url, params: user_params
        expect(response).to have_http_status :created
      end

      it "responds with new user information" do
        post url, params: user_params
        expect(parsed_body[:user]).to include("username" => user_params[:username])
        expect(parsed_body[:token]).to_not be_nil
        expect(parsed_body[:token].split(".").length).to eq 3
      end
    end
  end
end
