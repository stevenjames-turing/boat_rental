require './lib/renter'
require './lib/boat'
require './lib/dock'


RSpec.describe Dock do
  it 'exists' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock).to be_instance_of Dock 
  end
end
