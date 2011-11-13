module Little
  class Error < StandardError
    attr_accessor :code, :data
    def initialize(code, data)
      @code = code
      @data = data
    end
  end
end