class Airline < ApplicationRecord
  has_many :flights, dependent: :destroy
  has_many :passengers, through: :flights

  def unique_adult_frequent_flyers
    passengers
      .select("passengers.*, count(passengers.id) as number_of_flights")
      .group("passengers.id").where("age >= ?", 18)
      .order(number_of_flights: :desc)
      .distinct
  end
end
