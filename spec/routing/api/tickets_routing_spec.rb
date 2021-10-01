require "rails_helper"

RSpec.describe Api::TicketsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/api/tickets').to route_to('api/tickets#create', 'format' => :json)
    end
  end
end
