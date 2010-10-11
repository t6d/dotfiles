require 'fileutils'

module GitHelper
  
  def git(*args)
    if not `which git`.strip.empty?
      command = "git #{args.join(' ')}"
      
      puts command
      system command
    else
      raise "Git is not installed"
    end
  end
  
end

module FileHelper
  include FileUtils
  
  def backup(file)
    if File.exists?(file) and not File.symlink?(file)
      cp_r file, "#{file}.#{today}"
    end
  end
  
  def delete(file)
    if File.symlink?(file)
      rm file
    elsif File.exists?(file)
      if File.directory?(file)
        rm_r file
      else
        rm file
      end
    end
  end
  
  def link(source, destination)
    ln_s source, destination
  end
  
  def ignore?(file)
    case File.basename(file)
    when "Rakefile" then true
    else
      false
    end
  end
  
  private
  
  def today
    Time.now.strftime("%Y%m%d%H%M%S")
  end
  
end

include GitHelper
include FileHelper

# -- Tasks -----------------------------------------------------------------

task :default => :install

desc "Install all dotfiles"
task :install do
  Dir.glob(File.join(File.dirname(__FILE__), '*')) do |src|
    dst = File.expand_path(File.join('~', ".#{File.basename(src)}"))
    
    next if ignore?(src)
    
    backup(dst)
    delete(dst)
    link(src, dst)
  end
end

task :update do
  git 'pull'
end