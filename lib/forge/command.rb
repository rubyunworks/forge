require 'optparse'
require 'forge'

module Forge

  # Main Command-line interface.
  class Command

    # Initialize and run
    def self.run
      new.run
    end

    #
    attr :command

    #attr :options

    #
    def parse
      @command = ARGV.shift
    end

    # TODO: How is use alternate controllers?
    def controller
      Forge::Rubyforge
    end

    #
    def execute
      case command
      when '--help', '-h'
        help
      else
        begin
          interface = controller.const_get(command.capitalize).new
          interface.parse
          interface.run
        rescue => err
          raise err if $DEBUG
          $stderr << err.message + "\n"
        end
      end
    end

    #
    def run
      parse
      execute
    end

    # TODO: Help will need to depend on controller.
    def help
      h = []
      h << "Usage: forge [COMMAND] [OPTIONS ...]"
      h << ""
      h << "COMMANDS:"
      h << "  touch      login and logout to test connection"
      h << "  release    release package(s)"
      h << "  announce   make an announcement"
      h << "  publish    publish website"
      h << ""
      h << "Add --help after command to learn more about each."
      puts h.join("\n")
    end

  end

end

