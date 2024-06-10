module TurboEditable
  class Configuration
    attr_accessor :icons_framework
    attr_accessor :mode

    def initialize
      @icons_framework = :bi
      @mode = :pencil # :modern is other option
    end

  end
end
