require_relative 'item'
require_relative 'box_of_bolts'

class RobotAlreadyDeadError < StandardError
end

class UnattackableEnemy < StandardError
end

class Robot
  @@all_the_robots = []

  attr_reader :position, :items
  attr_accessor :health, :equipped_weapon, :shields

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @shields = 50
    @@all_the_robots << self
  end

  def move_left
    @position = [@position.first - 1, @position.last]
  end

  def move_right
    @position = [@position.first + 1, @position.last]
  end

  def move_up
    @position = [@position.first, @position.last + 1]
  end

  def move_down
    @position = [@position.first, @position.last - 1]
  end

  def pick_up(item)
    if item.weight + items_weight <= 250
      @equipped_weapon = item if item.is_a? Weapon
      @shields = 50 if item.is_a? Battery
      item.feed(self) if item.is_a?(BoxOfBolts) && health <= 80
      # Batteries are used and carried
      @items << item unless item.is_a? Battery
    end
  end

  def items_weight
    @items.inject(0) { |sum, item| sum + item.weight }
  end

  def wound(damage)
    # Figure out the damage with shields
    if (damage > @shields)
      damage -= @shields
      @shields = 0
    else
      @shields -= damage
      damage = 0
    end

    # The hit should be the minimum of the hit amount or the robot's health amount
    @health -= [@health, damage].min
  end

  def heal(amount)
    @health += [amount, 100 - @health].min
  end

  def heal!(amount)
    if @health > 0
      heal(amount)
    else
      raise RobotAlreadyDeadError 'Cannot heal dead robots'
    end
  end

  def attack(*other_robots)
    # Get the range of the weapon if available
    range = @equipped_weapon.respond_to?(:range) ? @equipped_weapon.range : 1
    other_robots.each do |enemy|
      enemy_position = enemy.position
      # Check if the other robot is in range
      if enemy_position.first.between?(@position.first - range, @position.first + range) &&
         enemy_position.last.between?(@position.last - range, @position.last + range)
        if @equipped_weapon
          @equipped_weapon.hit(enemy)
        else
          enemy.wound(5)
        end
      end
    end
    @equipped_weapon = nil
  end

  def attack!(other_robot)
    if other_robot.is_a? Robot
      attack(other_robot)
    else
      raise UnattackableEnemy 'Can only attack other robots'
    end
  end

  def scan
    robots_in_the_vicinity = []
    ((position.first - 1)..(position.first + 1)).each do |x|
      ((position.last - 1)..(position.last + 1)).each do |y|
        robots_in_the_vicinity.concat(self.class.in_position(x, y))
      end
    end
    robots_in_the_vicinity.delete(self)
    robots_in_the_vicinity
  end

  def self.all_the_robots
    @@all_the_robots
  end

  def self.in_position(x, y)
    robots = all_the_robots
    robots.select do |robot|
      robot.position == [x, y]
    end
  end

end
