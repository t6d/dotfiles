require 'irb/completion'
require 'rubygems' if RUBY_VERSION < '1.9'

begin
  require 'irbtools'
rescue LoadError
  puts "Warning: irbtools not installed"
end

def ri(query)
  puts `ri #{query}`
end

def home
  ENV['HOME']
end

def desktop
  File.join home, 'Desktop'
end

def benchmark
  if block_given?
    t = Time.now
    result = yield
    puts Time.now - t
    result
  else
    raise RuntimeError, "No block given", nil
  end
end