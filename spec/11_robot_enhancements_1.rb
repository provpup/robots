require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe '#heal!' do

    it 'should heal a living robot' do
      @robot.wound(70)
      expect { @robot.heal!(10) }.not_to raise_error
      expect(@robot.health).to eq(90)
    end

    it 'should not heal a dead robot' do
      # kill the robot
      @robot.wound(@robot.health + @robot.shields)
      expect { @robot.heal!(10) }.to raise_error
    end
  end

  describe '#attack!' do

    it 'should attack other robots' do
      robot2 = Robot.new
      # Create an expectation that by the end of this test,
      # the second robot will have had #wound method called on it
      # and 5 (the default attack hitpoints) will be passed into that method call
      expect(robot2).to receive(:wound).with(5)

      # This is what will trigger the wound to happen on robot2
      @robot.attack!(robot2)
    end

    it 'should not attack non-robots' do
      bolts = BoxOfBolts.new
      expect { @robot.attack!(bolts) }.to raise_error
    end
  end
  
end