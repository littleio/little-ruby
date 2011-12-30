require 'little/version'
require 'little/error'
require 'little/configuration'
require 'little/like'
require 'little/tag'
require 'little/attempt'
require 'little/notification'
require 'little/sender'

module Little #:nodoc
  class << self
    attr_accessor :sender
    attr_writer :configuration
    
    # Sets the configuration options. Best used by passing a block, for example:
    #
    #   Little.configure do |config|
    #     config.api_key = 'KEY'
    #     config.api_secret = 'SECRET'
    #   end
    def configure
      yield(configuration)
      self.sender = Sender.new(configuration)
    end
    
    # Can be used to generate a signature. Best to use specific signature methods such as Little::Like.sign_add(user)
    def sign(resource, params)
      params[:key] = configuration.api_key
      raw = params.sort{|a, b| a[0] <=> b[0]}.join('|') + '|' + configuration.api_secret + '|' + resource.to_s
      Digest::SHA1.hexdigest(raw)
    end
    
    # Gets the current configuration
    def configuration
      @configuration ||= Configuration.new
    end
    
    # Issues a POST request to the little.io service
    def post(resource, data, signature_keys)
      sender.post_request(resource, data, signature_keys)
    end
    # Issues a DELETE request to the little.io service
    # @param [String, Symbol] resource name of the resource (:tags, :likes, ...)
    # @param [Hash] data data to send to the service
    # @param [Array] signature_keys keys of the data used for signing (optional)
    def delete(resource, data, signature_keys)
      sender.delete_request(resource, data, signature_keys)
    end
    # Issues a GET request to the little.io service
    # @param [String, Symbol] resource name of the resource (:tags, :likes, ...)
    # @param [Hash] data data to send to the service
    # @param [Array] signature_keys keys of the data used for signing (optional)
    def get(resource, data, signature_keys = nil)
      sender.get_request(resource, data, signature_keys)
    end
  end
end