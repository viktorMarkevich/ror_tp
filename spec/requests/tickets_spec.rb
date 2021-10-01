 require 'rails_helper'

RSpec.describe "/tickets", type: :request do
  let(:ticket) { create :ticket }

  describe "GET /index" do
    it "renders a successful response" do
      get tickets_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get ticket_url(ticket)
      expect(response).to be_successful
    end
  end
end
