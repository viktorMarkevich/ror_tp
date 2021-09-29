module Api
  class TicketsController < ActionController::API
    def create
      ticket = Ticket.new(ticket_params)
      if ticket.save
        render json: ticket.to_json, status: :created
      else
        render json: ticket.errors, status: :unprocessable_entity
      end
    end

    private

    def ticket_params
      WhiteList.new(params[:ticket]).handle_payload
    end
  end
end