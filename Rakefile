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

  def ask(question, possible_answers = DEFAULT_ANSWERS)
    STDOUT.print "#{question} [#{possible_answers.keys.join}] "

    begin
      answer = STDIN.gets.strip.downcase.to_sym
    end until possible_answers.key?(answer)

    possible_answers[answer]
  end
end

include Helpers

task "install" do
  each_configuration_file do |file|
    next if file.exists? && !ask("Replace #{file.target}?")
    symlink(file.source, file.target, force: true)
  end
end