require 'forge/rubyforge/abstract'

class Forge::Rubyforge

  # = Rubyforge Publish Interface
  #
  class Publish < AbstractInterface

    # Site map
    attr_accessor :sitemap

    # Rsync filter
    attr_accessor :filter

    # Rsync delete?
    attr_accessor :delete

    # Extra RSync args
    attr_accessor :extra

    #sitemap = options['sitemap'] || config.sitemap
    #filter  = options['filter']  || config.rsync_filter
    #delete  = options['delete']  || config.rsync_delete
    #optargs = options['optargs'] || config.rsync_extra

    #
    def initialize(options)
      initialize_defaults
      options.each do |key, value|
        send("#{key}=", value)
      end
    end

    #
    def initilaize_defaults
      self.delete = false
    end

    #
    def sitemap=(file_of_hash)
      case file_or_hash
      when Hash
        @sitemap = file_or_hash
      else
        @sitemap = YAML.load(file_or_hash)
      end
    end

    #
    def parse
      opts_parser.on("--sitemap [FILE]", "sitemap file") do |file|
        self.sitemap = file
      end
      opts_parser.on("--filter [FILE]", "rsync filter") do |file|
        self.filter = file
      end
      opts_parser.on("--delete", "rsync delete? [false]") do
        self.delete = true
      end

      opt_parser.parse!

      self.extra = ARGV[ARGV.index('-')..-1]  # TODO: Is this right?
    end

    #
    def run
      rubforge.publish(
        :sitemap   => sitemap,
        :filter    => filter,
        :delete    => delete,
        :extra     => extra
      )
    end

  end

end

