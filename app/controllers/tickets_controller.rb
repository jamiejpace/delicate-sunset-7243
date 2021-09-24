class TicketsController < ApplicationController
  def destroy
    ticket = Ticket.find_by(flight_id: params[:id], passenger_id: params[:passenger_id])
    ticket.destroy
    redirect_to flights_path
  end
end
