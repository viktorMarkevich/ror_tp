require 'rails_helper'

describe TicketsController, type: :controller do
  let!(:ticket) { create :ticket }

  describe 'GET#INDEX' do
    context 'when return list' do
      before { get :index }

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns list of tickets' do
        expect(assigns(:tickets)).to eq([ticket])
      end
    end
  end

  describe 'GET#SHOW' do
    context 'when the ticket' do
      before { get :show, params: { id: ticket.id } }

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns list of tickets' do
        expect(assigns(:ticket)).to eq(ticket)
      end
    end
  end
end
