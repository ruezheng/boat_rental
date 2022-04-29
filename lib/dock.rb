class Dock
	attr_reader :name,
							:max_rental_time,
							:rental_log

	def initialize(name, max_rental_time)
		@name = name
		@max_rental_time = max_rental_time
		@rental_log = {}
	end

  def rent(boat, renter)
		@rental_log[boat] = renter
	end

	def charge(boat)
		charge = {}
		charge[:card_number] = @rental_log[boat].credit_card_number
		charge[:amount] = ([boat.hours_rented, @max_rental_time].min * boat.price_per_hour)
		# charge[:amount] = (boat.hours_rented.clamp(0, @max_rental_time) * boat.price_per_hour)
		charge
	end
end
