require 'rails_helper'

RSpec.describe "Drinks", type: :request do
  describe "GET /status" do
    let(:url) { "/status" }

    context "Unauthenticated request" do
      it "Does not check status" do
        get url
        expect(response).to have_http_status :unauthorized
      end
    end

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
        expect(parsed_body).to include("caffeine_status")
        expect(parsed_body["caffeine_status"]["last_day"].to_f)
          .to be_within(0.001)
          .of(total_caffeine)
        left_caffeine = 500 - total_caffeine
        expected_drinks_left = {
          drink1.id.to_s => (left_caffeine / (drink1.serv_caffeine * drink1.serv_count)).floor,
          drink2.id.to_s => (left_caffeine / (drink2.serv_caffeine * drink2.serv_count)).floor
        }
        expect(parsed_body["drinks_left"]). to eq expected_drinks_left
      end
    end
  end

  describe "GET /drinks" do
    let(:url) { "/drinks" }

    context "Unauthenticated request" do
      it "Does not check drinks" do
        get url
        expect(response).to have_http_status :unauthorized
      end
    end

    context "Authenticated request" do
      let(:user) { create(:user) }
      let(:parsed_body) { ActiveSupport::JSON.decode(response.body) }

      before { 3.times { create(:drink) } }

      it "checks available drinks" do
        get url, headers: authenticated_header(user)
        expect(parsed_body.length).to eq 3
        expect(parsed_body.first).to include("name")
      end
    end
  end
end
