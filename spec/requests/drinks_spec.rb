require 'rails_helper'

RSpec.describe "Drinks", type: :request do
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
