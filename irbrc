def ri(query)
  puts `ri #{query}`
end

def home
  ENV['HOME']
end

def desktop
  File.join home, 'Desktop'
end

require 'irb/completion'
require 'rubygems'

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