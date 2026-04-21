require 'pathname'

module Helpers
  ConfigurationFile = Struct.new(:source) do
    def target
      case source
      when /fish$/, /nvim$/, /zellij$/
        File.expand_path(File.join("~/.config", File.basename(source)))
      else
        File.expand_path(File.join("~/", ".%s" % File.basename(source)))
      end
    end

    def symlink
      FileUtils.symlink(source, target)
    end

    def remove
      return unless exist?

      if File.directory?(source)
        FileUtils.rm_r(target)
      else
        FileUtils.rm(target)
      end
    end

    def exist?
      File.exist?(target)
    end
  end

  DEFAULT_ANSWERS = {
    y: true,
    n: false
  }

  def each_configuration_file
    Dir.glob(File.expand_path('../lib/*', __FILE__)).each do |path|
      yield ConfigurationFile.new(path)
    end
  end

  def each_configuration_file_symlink
    pattern = File.join(File.dirname(__FILE__), 'lib', '*')
    symlinks = Dir.glob(File.expand_path('.*', '~/')).select do |path|
      Pathname(path).symlink? && Pathname(path).readlink.fnmatch?(pattern)
    end
    symlinks.each { |l| yield l }
  end

  def ask(question, possible_answers = DEFAULT_ANSWERS)
    STDOUT.print "#{question} [#{possible_answers.keys.join}] "

    begin
      answer = STDIN.gets.strip.downcase.to_sym
    end until possible_answers.key?(answer)

    possible_answers[answer]
  end
end

include Helpers

desc "Symlink configuration files"
task install: ["install:configuration_files"]

namespace :install do
  task :configuration_files do
    each_configuration_file do |file|
      next if file.exist? && !ask("Replace #{file.target}?")
      file.remove
      file.symlink
    end
  end
end

desc "Remove configuration file symlinks"
task "uninstall" do
  each_configuration_file_symlink { |f| rm f }
end
