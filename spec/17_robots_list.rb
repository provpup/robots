describe Robot do

  before(:each) do
    Robot.class_variable_set(:@@all_the_robots, [])
  end

  describe '@@all_the_robots' do
    it 'should include every new robot created' do
      robot = Robot.new
      expect(Robot.all_the_robots.include?(robot)).should be_truthy

      robot2 = Robot.new
      expect(Robot.all_the_robots.include?(robot2)).should be_truthy
    end
  end
end