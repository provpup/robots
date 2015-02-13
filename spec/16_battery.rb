require './spec_helper'

describe Battery do

  before :each do
    @battery = Battery.new 
  end

  it "should be an item" do
    expect(@battery).to be_an(Item)
  end

  it "should have name 'power_shock'" do
    expect(@battery.name).to eq("Battery")
  end

  it "should have weight 25" do
    expect(@battery.weight).to eq(25)
  end
end

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe '#pick_up' do
    it 'should pick_up a battery and recharge its shields' do
      @robot.wound(20)
      battery = Battery.new
      @robot.pick_up(battery)
      expect(@robot.shields).to eq(50)
    end
  end

end