require 'fileutils'
require 'open-uri'
require 'openssl'
require 'tmpdir'
require 'enumerator'

require 'ostruct'

require 'facets/kernel/ask'
require 'facets/module/alias_accessor'
require 'facets/hash/rekey'

require 'pom/project'

module Forge

  # = Support base class
  #
  class AbstractHost

    attr_accessor :verbose
    attr_accessor :force
    attr_accessor :metadata  # get this from Reap

    attr_accessor :trial
    attr_accessor :debug
    attr_accessor :trace
    attr_accessor :quiet

    #def verbose? ; @verbose ; end
    def force?   ; @force   ; end

    def debug?   ; $DEBUG || @debug ; end
    def trial?   ; $TRAIL || @trial ; end
    def trace?   ; $TRACE || @trace ; end
    def quiet?   ; $QUIET || @quiet ; end

    #
    def project
      @project ||= POM::Project.new(Dir.pwd)
    end

    #
    def metadata
      project.metadata
    end

    #
    def config
      @config ||=(
        if file = Dir['{,.}config/forge.yml']
          data = YAML.load(file)
        else
          data = {}
        end
        OpenStruct.new(data)
      )
    end

   private

    def initialize(options)
      initialize_defaults
      options.each do |k,v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
      yield(self) if block_given?
    end

    #
    def initialize_defaults
    end

    # TODO: replace with facets/string/unfold ?
    def unfold_paragraphs(string)
      blank = false
      text  = ''
      string.split(/\n/).each do |line|
        if /\S/ !~ line
          text << "\n\n"
          blank = true
        else
          if /^(\s+|[*])/ =~ line
            text << (line.rstrip + "\n")
          else
            text << (line.rstrip + " ")
          end
          blank = false
        end
      end
      return text
    end

    #
    def mkdir_p(dir)
      fu.mkdir_p(dir) unless File.directory?(dir)
    end

    #
    def fu
      if trial?
        FileUtils::DryRun
      elsif trace?
        FileUtils::Verbose
      else
        FileUtils
      end
    end

  end

end

