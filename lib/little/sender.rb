require 'json'
require 'net/http'
require 'net/https'

module Little
  class Sender
    BASE_URL = '/api/v1/'
    HEADERS = {'Accept' => 'application/json'}

    def initialize(configuration)
      @configuration = configuration
    end

    def get_request(resource, data, signature_keys, url)
      query_request(:get, resource, data, signature_keys, url)
    end
    
    def delete_request(resource, data, signature_keys, url)
      query_request(:delete, resource, data, signature_keys, url)
    end
    
    def post_request(resource, data, signature_keys, url)
      form_request(:post, resource, data, signature_keys, url)
    end
    
    def put_request(resource, data, signature_keys, url)
      form_request(:put, resource, data, signature_keys, url)
    end
    
    private
    def create_http(resource, data, signature_keys)
      http = Net::HTTP::Proxy(@configuration.proxy_host, @configuration.proxy_port, @configuration.proxy_user, @configuration.proxy_pass).new(@configuration.host, @configuration.port)
      http.read_timeout = @configuration.http_read_timeout
      http.open_timeout = @configuration.http_open_timeout
      http.use_ssl = @configuration.secure
      complete_data(resource, data, signature_keys)
      http
    end
    
    def complete_data(resource, data, signature_keys)
      data[:key] = @configuration.api_key
      return if signature_keys.nil?
      data[:sig] = Little.sign(resource, data.select{|k,v| signature_keys.include?(k)})
    end
    
    def url_encode(data)
      URI.encode_www_form(data)
    end
    
    def query_request(method, resource, data, signature_keys, url)
      response = nil
      begin
        http = create_http(resource, data, signature_keys)
        full_url = "#{BASE_URL}#{resource}"
        full_url += "/#{url}" unless url.nil?
        full_url += "?#{url_encode(data)}"
        response = http.send(method, full_url, HEADERS)
      rescue => e
        raise Little::Error.new(-1, e)
      end
      handle_response(response) unless response.nil?
    end
    
    def form_request(method, resource, data, signature_keys, url)
      response = nil
      begin
        http = create_http(resource, data, signature_keys)
        full_url = "#{BASE_URL}#{resource}"
        full_url += "/#{url}" unless url.nil?
        response = http.send(method, full_url, url_encode(data), HEADERS)
      rescue => e
        raise Little::Error.new(-2, e)
      end
      handle_response(response) unless response.nil?
    end
    
    def handle_response(response)
      body = response.body
      if body.length < 2
        data = nil
      elsif body == 'true'
        data = true
      elsif body == 'false'
        data = false
      elsif response['Content-Type'] =~ /application\/json/
        data = JSON.parse(response.body) 
      else
         data = response.body
      end
      return data if response.is_a?(Net::HTTPSuccess)
      raise Little::Error.new(response.code, data)
    end
  end
end