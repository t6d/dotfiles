require 'pathname'

module Helpers
  ConfigurationFile = Struct.new(:source) do
    def target
      File.expand_path(File.join("~/", ".%s" % File.basename(source)))
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
task install: ["install:configuration_files", "install:oh_my_zsh", "install:vim_plugins"]

namespace :install do
  task :configuration_files do
    each_configuration_file do |file|
      next if file.exists? && !ask("Replace #{file.target}?")
      symlink(file.source, file.target, force: true)
    end
  end
  
  task :oh_my_zsh do
    sh 'KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  end

  task :vim_plugins do
    sh 'vim +PlugInstall +qall'
  end
end

task "install" do
end

desc "Remove configuration files and uninstall Oh My ZSH!"
task "uninstall" do
  each_configuration_file_symlink { |f| rm f }
  File.expand_path("~/.oh-my-zsh").tap do |oh_my_zsh_installation_directory|
    next unless File.directory?(oh_my_zsh_installation_directory)
    rm_r oh_my_zsh_installation_directory 
  end
end
