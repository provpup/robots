describe Robot do
  
  before :each do
    Robot.class_variable_set(:@@all_the_robots, [])
    @robot = Robot.new
    @death_blossom = DeathBlossom.new
  end

  describe '#attack with death blossom weapon' do
    it 'should attack all robots in its immediate vicinity' do
      robot2 = Robot.new
      robot2.move_up
      robot2.move_right

      robot3 = Robot.new
      robot3.move_down
      robot3.move_left

      @robot.pick_up(@death_blossom)
      @robot.attack(*@robot.scan)
      expect(robot2.health).to eq(70)
      expect(robot2.shields).to eq(50)
      expect(robot3.health).to eq(70)
      expect(robot3.shields).to eq(50)
    end
  end

end