require 'rails_helper'

RSpec.describe 'flights index page' do
  before :each do
    @airline1 = Airline.create!(name: "Frontier")
    @airline2 = Airline.create!(name: "American")
    @flight1 = @airline1.flights.create!(number: "1727", date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
    @flight2 = @airline1.flights.create!(number: "7819", date: "08/05/20", departure_city: "LA", arrival_city: "London")
    @flight3 = @airline2.flights.create!(number: "2944", date: "08/06/20", departure_city: "SLC", arrival_city: "Seattle")
    @passenger1 = Passenger.create!(name: "Jamie", age: 33)
    @passenger2 = Passenger.create!(name: "Meg", age: 28)
    @passenger3 = Passenger.create!(name: "Acadia", age: 30)
    @passenger4 = Passenger.create!(name: "JD", age: 10)
    Ticket.create!(flight_id: @flight1.id, passenger_id: @passenger1.id)
    Ticket.create!(flight_id: @flight2.id, passenger_id: @passenger2.id)
    Ticket.create!(flight_id: @flight3.id, passenger_id: @passenger3.id)
    Ticket.create!(flight_id: @flight3.id, passenger_id: @passenger4.id)
  end

  it 'lists all flight numbers, their airline, and the names of all passengers' do
    visit flights_path
    save_and_open_page
    expect(page).to have_content(@flight1.number)
    expect(page).to have_content(@flight2.number)
    expect(page).to have_content(@flight3.number)
    expect(page).to have_content(@airline1.name)
    expect(page).to have_content(@airline2.name)
    expect(page).to have_content(@passenger1.name)
    expect(page).to have_content(@passenger2.name)
    expect(page).to have_content(@passenger3.name)
    expect(page).to have_content(@passenger4.name)
  end

  it 'has a link next to each passengers name to remove that passenger from that flight' do
    visit flights_path

    within("#passenger-#{@passenger1.id}") do
      expect(page).to have_content(@passenger1.name)
      click_link "Remove Passenger"
    end
    
    expect(current_path).to eq(flights_path)
    expect(page).to_not have_content(@passenger1.name)
  end
end
