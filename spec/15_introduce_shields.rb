require './spec_helper'

# The @robot can move around in two dimensional space.
# We can use an array to keep track of its X and Y position, which will
# by default start at 0, 0

describe Robot do

  # Since we are describing a Robot class,
  # all the nested descriptions here are referring to the @robot.

  # sets the variable @robot.to be a new @robot.
  before :each do
    @robot = Robot.new
  end

  # The pound symbol is a convention to imply that position is a callable method
  # This test is basically saying that it expects @robot.position == [0, 0]
  describe "#shields" do
    it "should start at 50" do
      expect(@robot.shields).to eq(50)
    end

    it "should protect against attacks" do
      @robot.wound(20)
      expect(@robot.shields).to eq(30)
    end
  end
end
