require 'rspec'
require './lib/dock'
require './lib/renter'
require './lib/boat'

describe Dock do
	let(:dock) { Dock.new("The Rowing Dock", 3) }
	let(:kayak_1) { Boat.new(:kayak, 20) }
	let(:kayak_2) { Boat.new(:kayak, 20) }
	let(:sup_1) { Boat.new(:standup_paddle_board, 15) }
	let(:patrick) { Renter.new("Patrick Star", "4242424242424242") }
	let(:eugene) { Renter.new("Eugene Crabs", "1313131313131313") }

	it "exist" do
		expect(dock).to be_an_instance_of Dock
	end

	it "has attributes" do
		expect(dock.name).to eq "The Rowing Dock"
		expect(dock.max_rental_time).to eq 3
		expect(dock.rental_log).to eq({})
	end

	describe 'iteration III' do
		before :each do
			dock.rent(kayak_1, patrick)
			dock.rent(kayak_2, patrick)
			dock.rent(sup_1, eugene)
			kayak_1.add_hour
			kayak_1.add_hour
		end

		it "can return a hash logging rentals" do
			expected = {
				kayak_1 => patrick,
				kayak_2 => patrick,
				sup_1 => eugene
			}

			expect(dock.rental_log).to eq(expected)
		end

		it "can charge for rental time" do
			expected = {
				:card_number => "4242424242424242",
				:amount => 40
			}
			expect(dock.charge(kayak_1)).to eq(expected)
		end

		it "doesn't charge beyond max rental time" do
			sup_1.add_hour
			sup_1.add_hour
			sup_1.add_hour
			sup_1.add_hour
			sup_1.add_hour

			expected = {
				:card_number => "1313131313131313",
				:amount => 45
			}
			expect(dock.charge(sup_1)).to eq(expected)
		end
	end
end
