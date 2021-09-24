class Passenger < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :flights, through: :tickets
end
