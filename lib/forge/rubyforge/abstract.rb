require 'forge/rubyforge'
require 'optparse'

class Forge::Rubyforge

  # Base Class for Rubyforge Interfaces
  #
  class AbstractInterface

    # Project unixname.
    attr_accessor :unixname

    # Project's group id number.
    attr_accessor :groupid

    # Username for project account.
    attr_accessor :username

    # Password for project account.
    attr_accessor :password

    #
    def initialize
      $TRIAL = false
      $TRACE = false
    end

    # Access to Rubyforge API
    def rubyforge
      @rubyforge ||= Forge::Rubyforge.new(
        :unixname => unixname,
        :groupid  => groupid,
        :username => username,
        :password => password
      )
    end

    #
    def opts_parser
      @opts_parser ||= OptionParser.new do |opts_parser|
        opts_parser.banner = "Usage: forge <COMMAND> [OPTIONS]"
        opts_parser.on("--unixname [NAME]", "project's unixname") do |name|
          self.unixname = name
        end
        opts_parser.on("--groupid [ID]", "project's group-id") do |id|
          self.groupid = id
        end
        opts_parser.on("--username", "-u [NAME]", "rubyforge account username") do |name|
          self.username = name
        end
        opts_parser.on("--password", "-p [PASS]", "rubyforge account password") do |pass|
          self.password = pass
        end
        opts_parser.on("--debug", "run in debug mode") do
          $DEBUG   = true
          $VERBOSE = true  # wish this were called $WARN
        end
        opts_parser.on("--trial", "run in trial mode") do
          $TRIAL = true
          #self.trial = true
        end
        opts_parser.on("--quiet", "-q", "surpress output") do
          $QUIET = true
          #self.quiet = true
        end
        opts_parser.on("--trace", "-t", "show execution details") do
          $TRACE = true
          #self.trace = true
        end
        opts_parser.on_tail('--help', '-h', "show this help information") do
          puts opts_parser
          exit
        end
      end
    end

    # Override by subclasses.
    def parse
      opts_parser.parse!
    end

  end

end

