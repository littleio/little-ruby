module Little
  class Configuration
    OPTIONS = [
      :api_key, :api_secret, 
      :host, :port, :secure, 
      :http_open_timeout, :http_read_timeout,
      :proxy_host, :proxy_pass, :proxy_port, :proxy_user].freeze
    
    attr_accessor :api_key, :api_secret
    attr_accessor :host, :secure
    attr_accessor :http_open_timeout, :http_read_timeout
    attr_accessor :proxy_host, :proxy_port, :proxy_user, :proxy_pass

    def port=(value)
      @port = value
    end
    def port
      defined?(@port) ? @port : (secure ? 443 : 80)
    end
      
    def initialize
      @secure = true
      @host = 'api.little.io'
      @http_open_timeout = 2
      @http_read_timeout = 5
    end
  end
end
