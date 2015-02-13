require 'pry'
require 'rspec'
require 'rspec/its'
require './safe_require'

safe_require 'robot'
safe_require 'item'
safe_require 'weapon'
safe_require 'box_of_bolts'
safe_require 'laser'
safe_require 'plasma_cannon'
safe_require 'grenade'
safe_require 'battery'
safe_require 'death_blossom'
 
RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
