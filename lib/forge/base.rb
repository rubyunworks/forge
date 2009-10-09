require 'fileutils'
require 'open-uri'
require 'openssl'
require 'tmpdir'
require 'enumerator'

require 'ostruct'
require 'httpclient'

#require 'facets' #/hash/rekey'
require 'facets/kernel/ask'
require 'facets/module/alias_accessor'
require 'facets/hash/rekey'

require 'pom/project'

module Forge

  # = Support base
  #
  class Base

    attr_accessor :dryrun
    attr_accessor :verbose
    attr_accessor :quiet
    attr_accessor :trace
    attr_accessor :debug
    attr_accessor :force
    attr_accessor :metadata  # get this from Reap

    def quiet?   ; @quiet   ; end
    def verbose? ; @verbose ; end
    def force?   ; @force   ; end
    def dryrun?  ; @dryrun  ; end
    def trace?   ; @trace   ; end
    def debug?   ; @debug   ; end

    # TODO: Can we get this from Reap?
    #def metadata
    #  @metadata ||= Pom::Metadata.new
    #end

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
      fu.mkdir_p(dir)
    end

    #
    def fu
      if dryrun?
        FileUtils::DryRun
      else
        FileUtils
      end
    end

  end

end

