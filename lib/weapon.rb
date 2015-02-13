class Weapon < Item

  attr_reader :damage

  def initialize(weapon_name, weight, damage)
    super(weapon_name, weight)
    @damage = damage
  end

  def hit(robot)
    robot.wound(damage)
  end

end