require 'forge/rubyforge/abstract'

class Forge::Rubyforge

  # = Rubyforge Touch Interface
  #
  class Touch < AbstractInterface

    #
    def run
      rubyforge.touch
    end

  end

end

