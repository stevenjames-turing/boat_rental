require './lib/renter'
require './lib/boat'


RSpec.describe Boat do
  it 'exists' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak).to be_instance_of(Boat)
  end

  it 'instantiates with a boat type' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.type).to eq(:kayak)
  end

  it 'instantiates with cost per hour' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.price_per_hour).to eq(20)
  end

  it 'instantiates with 0 hours rented' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.hours_rented).to be 0
  end

  it 'tracks the total hours rented' do
    kayak = Boat.new(:kayak, 20)
    expect(kayak.hours_rented).to be 0

    kayak.add_hour
    kayak.add_hour
    kayak.add_hour

    expect(kayak.hours_rented).to be 3
  end 



end
