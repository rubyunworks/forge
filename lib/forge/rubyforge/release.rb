require 'forge/rubyforge/abstract'

class Forge::Rubyforge

  # = Rubyforge Release Interface
  #
  class Release < AbstractInterface

    # Package name
    attr_accessor :package

    # Release name (defaults to package version number)
    attr_accessor :release #version

    # Release date
    attr_accessor :date

    # Release notes
    attr_accessor :notes

    # Change list
    attr_accessor :changes

    # Processor type
    attr_accessor :processor

    # The command line option for this is the opposite <tt>--private</tt>.
    attr_accessor :is_public

    # List of files to release.
    attr_accessor :files

    #
    def initialize(options)
      initilaize_defaults
      #self.files = options[:files] || options[:file] || []
      options.each do |key, value|
        send("#{key}=", value)
      end
    end

    #
    def initilaize_defaults
      self.processor = 'Any'
      self.date      = Time::now.strftime('%Y-%m-%d %H:%M')
      #self.package   = metadata.name
      #self.version   = metadata.version
      #self.date      = metadata.released || Time::now.strftime('%Y-%m-%d %H:%M')
      #self.changes   = project.history.releases[0].changes
      #self.notes     = project.history.releases[0].note
      #self.release   = version
      #self.files     = []
      self.is_public  = true
    end

    #
    def private=(value)
      @is_public = !value
    end

    #
    def notes=(file_or_text)
      if File.exist?(file_or_text)       
        @notes = File.read(file_or_text)
      else
        @notes = file_or_text
      end
    end

    #
    def changes=(file_or_text)
      if File.exist?(file_or_text)       
        @changes = File.read(file_or_text)
      else
        @changes = file_or_text
      end
    end

    #
    def parse
      opts_parser.on("--package [NAME]", "package name") do |name|
        self.package = name
      end
      opts_parser.on("--release [NAME]", "release name (defaults to version)") do |type|
        self.processor = type
      end
      opts_parser.on("--date [DATE]", "release date (defaults to present)") do |date|
        self.date = date
      end
      opts_parser.on("--changes [FILE]", "file detailing list of changes") do |file|
        self.changes = file
      end
      opts_parser.on("--notes [FILE]", "file detailing release notes") do |file|
        self.notes = file
      end
      opts_parser.on("--private", "private release?") do
        self.is_public = false
      end
      opts_parser.on("--processor [TYPE]", "processor type [Any]") do |type|
        self.processor = type
      end

      opts_parser.parse!

      @files = ARGV
    end

    #
    def run
      rubforge.release(
        :package   => package,
        :release   => release,
        :date      => date,
        :notes     => notes,
        :changes   => changes,
        :processor => processor,
        :is_public => is_public
      )
    end

  end

end

