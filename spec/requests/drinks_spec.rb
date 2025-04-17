require 'rails_helper'

RSpec.describe "Drinks", type: :request do
  describe "GET /drinks" do
    let(:url) { "/drinks" }

    it "Checks user's drinks" do
      expect(authenticated_header).to eq 4
    end
    # pending "add some examples (or delete) #{__FILE__}"
  end
end
