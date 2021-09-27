 require 'rails_helper'

RSpec.describe "/tickets", type: :request do
  
  # Ticket. As you add validations to Ticket, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Ticket.create! valid_attributes
      get tickets_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      ticket = Ticket.create! valid_attributes
      get ticket_url(ticket)
      expect(response).to be_successful
    end
  end
end
