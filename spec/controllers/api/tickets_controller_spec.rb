require 'rails_helper'

describe Api::TicketsController, type: :controller do
  describe 'POST#CREATE' do
    context 'with VALID params' do
      let(:valid_params) { { ticket: payload } }

      it 'returns status 201' do
        post :create, params: valid_params

        expect(response).to have_http_status(:created)
      end

      it 'returns plus one ticket and one associated excavator' do
        expect do
          post :create, params: valid_params
        end.to change(Ticket, :count).from(0).to(1)
                                     .and change(Excavator, :count).from(0).to(1)
      end
    end

    context 'with INVALID params' do
      let(:invalid_params) { { ticket: payload.merge('RequestNumber' => nil) } }

      it 'returns status 422' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns count eq 0' do
        expect do
          post :create, params: invalid_params
        end.to change(Ticket, :count).by(0)
                                     .and change(Excavator, :count).by(0)
      end
    end
  end
end
