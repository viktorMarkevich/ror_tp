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
      params.require(:ticket).permit(:request_number, :sequence_number, :request_type,
                                     :response_due_date, :primary_sacode, :digsite_info_wkt,
                                     additional_sacode: [])
    end
  end
end