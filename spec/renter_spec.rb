require './lib/renter'
require './lib/boat'


RSpec.describe Renter do
  it 'exists' do
    renter = Renter.new("Patrick Star", "4242424242424242")

    expect(renter).to be_instance_of(Renter)
  end

  it 'instantiates with a name' do
    renter = Renter.new("Patrick Star", "4242424242424242")

    expect(renter.name).to eq("Patrick Star")
  end

  it 'instantiates with a credit card number' do
    renter = Renter.new("Patrick Star", "4242424242424242")

    expect(renter.credit_card_number).to eq("4242424242424242")
  end
end
