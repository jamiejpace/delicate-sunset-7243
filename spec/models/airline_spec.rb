require 'rails_helper'

RSpec.describe Airline do
  describe 'relationships' do
    it { should have_many(:flights) }
    it { should have_many(:passengers).through(:flights) }
  end

  describe 'instance methods' do
    describe '.unique_adult_passengers' do
      before :each do
        @airline1 = Airline.create!(name: "Frontier")
        @flight1 = @airline1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
        @flight2 = @airline1.flights.create!(number: "7819", date: "08/05/20", departure_city: "LA", arrival_city: "London")
        @flight3 = @airline1.flights.create!(number: "2944", date: "08/06/20", departure_city: "SLC", arrival_city: "Seattle")
        @passenger1 = Passenger.create!(name: "Jamie", age: 33)
        @passenger2 = Passenger.create!(name: "Meg", age: 28)
        @passenger3 = Passenger.create!(name: "Acadia", age: 30)
        @passenger4 = Passenger.create!(name: "JD", age: 10)
        Ticket.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
        Ticket.create!(flight_id: @flight2.id, passenger_id: @passenger2.id)
        Ticket.create!(flight_id: @flight3.id, passenger_id: @passenger3.id)
        Ticket.create!(flight_id: @flight3.id, passenger_id: @passenger4.id)
        Ticket.create!(flight_id: @flight3.id, passenger_id: @passenger1.id)
      end

      it 'returns all unique passengers for airline 18 or older' do
        expect(@airline1.unique_adult_passengers).to eq([@passenger1, @passenger2, @passenger3])
      end
    end
  end
end
