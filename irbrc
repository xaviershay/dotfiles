script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
  
  def mq
    include ActiveMessaging::MessageSender
    self.class.instance_eval { publishes_to :model_events }
  end

  # In irb, can type:
  # people/6 instead of Person.find(6)
  # That is, can paste in urls into irb to find objects.
  class ModelProxy
    def initialize(klass)
      @klass = klass
    end
    def /(id)
      @klass.find(id)
    end
  end

  def mfs
    model_files = Dir.glob("app/models/**/*.rb")
    model_names = model_files.map { |f| File.basename(f).split('.')[0..-2].join }
    model_names.each do |model_name|
      Object.instance_eval do
        define_method(model_name.pluralize) do |*args|
          ModelProxy.new(model_name.camelize.constantize)
        end
      end
    end
  end

  def buy(product_id = 1379900, user_name = 'xshay')
    cart = User.find_by_user_name(user_name).cart
    cp = ConfiguredProduct.new(:cart => cart, :product_id => product_id, :quantity => 1)
    cp.build_default_buyer_option_values
    cp.save!
  end

end

def Object.method_added(method)
  return super(method) unless method == :helper
  (class<<self;self;end).send(:remove_method, :method_added)

  def helper(*helper_names)
    returning $helper_proxy ||= Object.new do |helper|
      helper_names.each { |h| helper.extend "#{h}_helper".classify.constantize }
    end
  end

  helper.instance_variable_set("@controller", ActionController::Integration::Session.new)

  def helper.method_missing(method, *args, &block)
    @controller.send(method, *args, &block) if @controller && method.to_s =~ /_path$|_url|path_for_group$/
  end

  helper :application rescue nil
end if ENV['RAILS_ENV']

def xshay
  User.find_by_user_name("xshay")
end

def un(name)
	User.find_by_user_name(name)
end

module Enumerable
	def c sym
		collect(&sym)
	end
end
# Some credits:
# Code this verions is based on: Andrew Birkett
#   http://www.nobugs.org/developer/ruby/method_finder.html
# Improvements from _why's blog entry
# * what? == - _why
# * @@blacklist - llasram
# * $stdout redirect - _why
#   http://redhanded.hobix.com/inspect/stickItInYourIrbrcMethodfinder.html
# Improvements from Nikolas Coukouma
# * Varargs and block support
# * Improved catching
# * Redirecting $stdout and $stderr (independently of _why)
#   http://atrustheotaku.livejournal.com/339449.html
# Improvement from Anthony Bailey
# * Prevent breaking when reloaded
#   http://nikolasco.livejournal.com/339449.html?thread=789241
#
# A version posted in 2002 by Steven Grady:
#   http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/32844
# David Tran's versions:
# * Simple
#   http://www.doublegifts.com/pub/ruby/methodfinder.rb.html
# * Checks permutations of arguments
#   http://www.doublegifts.com/pub/ruby/methodfinder2.rb.html
#
# Last updated: 2007/01/04

class Object
  def what?(*a)
    MethodFinder.new(self, *a)
  end
  def _clone_
    self.clone
  rescue TypeError
    self
  end
end

class DummyOut
  def write(*args)
  end
end

class MethodFinder
  @@blacklist = %w(daemonize display exec exit! fork sleep system syscall what?)
  
  def initialize( obj, *args )
    @obj = obj
    @args = args
  end
  def ==( val )
    MethodFinder.show( @obj, val, *@args )
  end
  
  # Find all methods on [anObject] which, when called with [args] return [expectedResult]
  def self.find( anObject, expectedResult, *args, &block )
    stdout, stderr = $stdout, $stderr
    $stdout = $stderr = DummyOut.new
    # change this back to == if you become worried about speed and warnings.
    res = anObject.methods.
          select { |name| anObject.method(name).arity <= args.size }.
          select { |name| not @@blacklist.include? name }.
          select { |name| begin 
                   anObject._clone_.method( name ).call( *args, &block ) == expectedResult; 
                   rescue Object; end }
    $stdout, $stderr = stdout, stderr
    res
  end
  
  # Pretty-prints the results of the previous method
  def self.show( anObject, expectedResult, *args, &block)
    find( anObject, expectedResult, *args, &block).each { |name|
      print "#{anObject.inspect}.#{name}" 
      print "(" + args.map { |o| o.inspect }.join(", ") + ")" unless args.empty?
      puts " == #{expectedResult.inspect}" 
    }
  end
end


# load libraries
require 'rubygems'
require 'wirble'

# start wirble (with color)
Wirble.init
Wirble.colorize
module Kernel

  # which { some_object.some_method() } => <file>:<line>:
  def where_is_this_defined(settings={}, &block)
    settings[:debug] ||= false
    settings[:educated_guess] ||= false
    
    events = []
    
    set_trace_func lambda { |event, file, line, id, binding, classname|
      events << { :event => event, :file => file, :line => line, :id => id, :binding => binding, :classname => classname }
      
      if settings[:debug]
        puts "event => #{event}"
        puts "file => #{file}"
        puts "line => #{line}"
        puts "id => #{id}"
        puts "binding => #{binding}"
        puts "classname => #{classname}"
        puts ''
      end
    }
    yield
    set_trace_func(nil)

    events.each do |event|
      next unless event[:event] == 'call' or (event[:event] == 'return' and event[:classname].included_modules.include?(ActiveRecord::Associations))
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}"
    end
    
    # def self.crazy_custom_finder
    #  return find(:all......)
    # end
    # return unless event == 'call' or (event == 'return' and classname.included_modules.include?(ActiveRecord::Associations))
    # which_file = "Line \##{line} of #{file}"
    if settings[:educated_guess] and events.size > 3
      event = events[-3]
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}"
    end
    
    return 'Unable to determine where method was defined.'
  end

end
