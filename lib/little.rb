require 'little/version'
require 'little/error'
require 'little/configuration'
require 'little/like'
require 'little/sender'

module Little
  class << self
    attr_accessor :sender
    attr_writer :configuration
    
    def configuration
      @configuration ||= Configuration.new
    end
    
    def configure
      yield(configuration)
      self.sender = Sender.new(configuration)
    end
    
    def post(resource, data, signature_keys)
      sender.post_request(resource, data, signature_keys)
    end
    def get(resource, data, signature_keys)
      sender.make_request(:get, resource, data, signature_keys)
    end

  end
end