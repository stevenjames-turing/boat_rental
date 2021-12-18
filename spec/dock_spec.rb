require './lib/renter'
require './lib/boat'
require './lib/dock'


RSpec.describe Dock do
  it 'exists' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock).to be_instance_of Dock
  end

  it 'instantiates with a name' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock.name).to eq("The Rowing Dock")
  end

  it 'instantiates with a maximum rental time' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock.max_rental_time).to eq(3)
  end

  it 'can rent a Boat to a Renter' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    dock.rent(kayak_1, patrick)

    expect(dock.rental_log.keys).to eq([kayak_1])
    expect(dock.rental_log.values).to eq([patrick])
  end

  it 'can rent multiple Boats to one Renter' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    expect(dock.rental_log.keys).to eq([kayak_1, kayak_2])
    expect(dock.rental_log.values).to eq([patrick, patrick])
  end

  it 'can rent multiple Boats to multiple Renters' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    expected = {
   kayak_1=> patrick,
   kayak_2=> patrick,
   sup_1=> eugene}

   expect(dock.rental_log).to eq(expected)
  end

  it 'can track the total dollar amount to be charged based upon rental time and price per hour' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    dock.rent(kayak_1, patrick)
    kayak_1.add_hour
    kayak_1.add_hour

    expected = {
      :card_number => "4242424242424242",
      :amount => 40}

    expect(dock.charge(kayak_1)).to eq(expected)
  end

  it 'limits the total charge amount based upon the max rental time per dock' do
    dock = Dock.new("The Rowing Dock", 3)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(sup_1, eugene)
    sup_1.add_hour

    expected_1hour = {
      :card_number => "1313131313131313",
      :amount => 15}

    expect(dock.charge(sup_1)).to eq(expected_1hour)

    sup_1.add_hour
    sup_1.add_hour

    expected_3hour = {
      :card_number => "1313131313131313",
      :amount => 45}

      expect(dock.charge(sup_1)).to eq(expected_3hour)

      sup_1.add_hour
      sup_1.add_hour

    expected_5hour = {
      :card_number => "1313131313131313",
      :amount => 45}

      expect(dock.charge(sup_1)).to eq(expected_5hour)
  end

  it 'logs the hours for each rental as they accrue' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    dock.log_hour

    expected_rental_log = {
      kayak_1=> patrick,
      kayak_2=> patrick}

    expected_charge_kayak1 = {
      :card_number => "4242424242424242",
      :amount => 20}

    expect(dock.rental_log).to eq(expected_rental_log)
    expect(dock.charge(kayak_1)).to eq(expected_charge_kayak1)
  end


end
