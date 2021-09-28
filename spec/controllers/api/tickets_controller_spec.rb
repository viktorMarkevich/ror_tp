require 'rails_helper'

describe Api::TicketsController, type: :controller do
  describe 'POST#CREATE' do
    context 'with VALID params' do
      let(:valid_params) { { ticket: (attributes_for :ticket) } } # TODO: change it to required JSON

      it 'returns status 201' do
        post :create, params: valid_params

        expect(response).to have_http_status(:created)
      end

      it 'returns plus one ticket and one associated excavator' do
        expect do
          post :create, params: valid_params
        end.to change(Ticket, :count).from(0).to(1)
        # TODO: add spec to check inc of excavator
      end
    end

    context 'with INVALID params' do
      let(:invalid_params) { { ticket: (attributes_for :ticket, :invalid_data) } } # TODO: change it to required JSON

      it 'returns status 422' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns count eq 0' do
        expect do
          post :create, params: invalid_params
        end.to change(Ticket, :count).by(0)
        # TODO: add spec to check inc of excavator
      end
    end
  end
end
