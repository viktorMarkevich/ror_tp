 require 'rails_helper'

RSpec.describe "/api/tickets", type: :request do
  let(:valid_attributes) {
    payload
  }

  let(:invalid_attributes) {
    payload.merge('RequestNumber' => nil)
  }

  describe "post /create" do
    it "renders a successful response" do
      post api_tickets_url, params: valid_attributes
      expect(response).to be_successful
    end

    it "renders a NOT successful response" do
      post api_tickets_url, params: invalid_attributes
      expect(response).not_to be_successful
    end
  end
end
