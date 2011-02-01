script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
#  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))

  def factory
    require 'sham'
    require 'machinist'
    require 'spec/blueprints'
  end
end

module Enumerable
	def c sym
		collect(&sym)
	end
end

# load libraries
require 'rubygems'

# start wirble (with color)
begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
  # meh
end
