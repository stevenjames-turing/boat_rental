require './lib/renter'
require './lib/boat'


RSpec.describe Renter do
  it 'exists' do
    renter = Renter.new("Patrick Star", "4242424242424242")

    expect(renter).to be_instance_of(Renter)
  end
end
