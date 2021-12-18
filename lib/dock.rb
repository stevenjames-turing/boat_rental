class Dock

  attr_reader :name, :max_rental_time, :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    charge = {
      card_number: (@rental_log[boat].credit_card_number),
      amount: ((boat.hours_rented < @max_rental_time) ? (boat.hours_rented * boat.price_per_hour) : (@max_rental_time * boat.price_per_hour))}
  end

  def log_hour
    @rental_log.keys.each do |boat|
      boat.add_hour
    end
  end

  def revenue
  end
end
