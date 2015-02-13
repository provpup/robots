class DeathBlossom < Weapon

  attr_reader :range

  def initialize
    super('Death Blossom', 100, 30)
    @range = 1
  end

  def hit(robot)
    # Death blossom has no effect against shields
    # It directly damages health
    old_robot_shields = robot.shields
    robot.wound(damage + old_robot_shields)
    robot.shields = old_robot_shields
  end
end