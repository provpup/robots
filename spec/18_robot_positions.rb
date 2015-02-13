describe Robot do

  before(:each) do
    Robot.class_variable_set(:@@all_the_robots, [])
    @robot1 = Robot.new
  end

  describe '.in_position' do
    it 'should find all robots in a given position' do
      robot2 = Robot.new

      expect(Robot.in_position(0,0).include?(@robot1)).to be_truthy
      expect(Robot.in_position(0,0).include?(robot2)).to be_truthy
    end

    it 'should not include robots who are out of position' do
      @robot1.move_up
      @robot1.move_right

      expect(Robot.in_position(0,0).include?(@robot1)).to be_falsey
    end
  end
end