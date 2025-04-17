require 'rails_helper'

RSpec.describe "/user_drinks", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do
    context "Without authentication" do
      it "does not check user's drinks" do
        get user_drinks_url
        expect(response).to have_http_status :unauthorized
      end
    end

    context "With authentication" do
      let(:other_user) { create(:user) }
      let(:drink1) { create(:drink) }
      let(:drink2) { create(:drink) }
      let(:parsed_body) { ActiveSupport::JSON.decode(response.body) }

      before do
        create(:user_drink, user: user, drink: drink1)
        create(:user_drink, user: user, drink: drink2)
        create(:user_drink, user: other_user, drink: drink2)
        travel_to(36.hours.ago) do
          create(:user_drink, user: user, drink: drink1)
          create(:user_drink, user: user, drink: drink2)
        end
      end

      it "renders a successful response" do
        get user_drinks_url, headers: authenticated_header(user), as: :json
        expect(response).to be_successful
        expect(parsed_body.length).to eq 2
        response_drink_ids = parsed_body.map { |item| item["drink_id"] }.sort
        sorted_drinks = [ drink1.id, drink2.id ].sort
        (0...response_drink_ids.length).each do |index|
          expect(response_drink_ids[index]).to eq sorted_drinks[index]
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:drink) { create(:drink) }
      it "creates a new UserDrink" do
        expect {
          post user_drinks_url,
          params: { drink_id: drink.id }, headers: authenticated_header(user)
        }.to change(UserDrink, :count).by(1)
      end
    end

    context "without authentication" do
      it "does not create a new UserDrink" do
        expect {
          post user_drinks_url
        }.to change(UserDrink, :count).by(0)
      end

      it "renders a JSON response with errors for the new user_drink" do
        post user_drinks_url
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
