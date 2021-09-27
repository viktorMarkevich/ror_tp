require "rails_helper"

RSpec.describe TicketsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tickets").to route_to("tickets#index")
    end

    it "routes to #show" do
      expect(get: "/tickets/1").to route_to("tickets#show", id: "1")
    end
  end
end
