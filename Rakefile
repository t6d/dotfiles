require 'pathname'

module Helpers
  ConfigurationFile = Struct.new(:source) do
    def target
      case source
      when /fish$/
        File.expand_path(File.join("~/.config", File.basename(source)))
      else
        File.expand_path(File.join("~/", ".%s" % File.basename(source)))
      end
    end

    def symlink
      FileUtils.symlink(source, target)
    end

    def remove
      return unless exists?

      if File.directory?(source)
        FileUtils.rm_r(target)
      else
        FileUtils.rm(target)
      end
    end

    def exists?
      File.exists?(target)
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

desc "Symlink configuration files, setup Oh My ZSH!, and install vim plugins"
task install: ["install:configuration_files", "install:vim_plugins"]

namespace :install do
  task :configuration_files do
    each_configuration_file do |file|
      next if file.exists? && !ask("Replace #{file.target}?")
      file.remove
      file.symlink
    end
  end

  task :oh_my_zsh do
    sh 'KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  end

  task :vim_plugins do
    sh 'vim +PlugInstall +qall'
  end
end

desc "Remove configuration files and uninstall Oh My ZSH!"
task "uninstall" do
  each_configuration_file_symlink { |f| rm f }
end
