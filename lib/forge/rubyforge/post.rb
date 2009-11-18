require 'forge/rubyforge/abstract'

class Forge::Rubyforge

  # = Rubyforge Post News Interface
  #
  class Post < AbstractInterface

    #
    attr_accessor :subject

    #
    attr_accessor :message

    #
    def initialize_defaults
      self.subject = "We're talking about #{unixname}!"
      self.message = ""
    end

    #
    def message=(file_or_text)
      if File.exist?(file_or_text)
        @message = File.read(file_or_text)
      else
        @message = file_or_text
      end
    end 

    #
    def parse
      opts_parser.on("--subject [TEXT]", "subject of message") do |text|
        self.subject = text
      end
      opts_parser.on("--message [FILE]", "file containing message") do |file|
        self.message = file
      end
      opts_parser.parse!
    end

  end

end

