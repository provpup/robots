describe Robot do
  
  before :each do
    Robot.class_variable_set(:@@all_the_robots, [])
    @robot = Robot.new
  end

  describe '#scan' do
    it 'should find all robots in its immediate vicinity' do
      robot2 = Robot.new
      robot2.move_up
      robot2.move_right

      robot3 = Robot.new
      robot3.move_down
      robot3.move_left

      expect(@robot.scan.include?(robot2)).to be_truthy
      expect(@robot.scan.include?(robot3)).to be_truthy
    end

    it 'should not find any robots outside its immediate vicinity' do
      robot2 = Robot.new
      robot2.move_up
      robot2.move_up
      robot2.move_right
      robot2.move_right

      robot3 = Robot.new
      robot3.move_down
      robot3.move_down
      robot3.move_left
      robot3.move_left

      expect(@robot.scan.include?(robot2)).to be_falsey
      expect(@robot.scan.include?(robot3)).to be_falsey
    end
  end

end