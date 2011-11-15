require 'spec_helper'

describe 'sender' do
  it "properly sets up http objects for post" do  #ugh...
    setup_configuration({:proxy_host => 'proxy', :proxy_port => 8080, :proxy_user => 'secret', :proxy_pass => 'sauce'})
    http = stub_http(:post, SuccessResponse.new('{}'))
    Little::Sender.new(@configuration).post_request(:test, {}, nil)
  end

  it "properly sets up http objects for get" do  #ugh...
    setup_configuration({:proxy_host => 'proxy', :proxy_port => 8080, :proxy_user => 'secret', :proxy_pass => 'sauce'})
    http = stub_http(:get, SuccessResponse.new('{}'))
    Little::Sender.new(@configuration).get_request(:test, {}, nil)
  end
  
  it "adds the api_key to a post request" do
    setup_configuration({:api_key => 'the-key'})
    stub_http(:post).should_receive(:post) do |url, data, headers|
      data.should include('key=the-key')
      SuccessResponse.blank
    end
    Little::Sender.new(@configuration).post_request(:test, {}, nil)  
  end
  
  it "adds the api_key to a get request" do
    setup_configuration({:api_key => 'the-key2'})
    stub_http(:get).should_receive(:get) do |url, headers|
      url.should include('key=the-key2')
      SuccessResponse.blank
    end
    sender = Little::Sender.new(@configuration)
    sender.get_request(:test, {}, nil)  
  end
  
  it "does not sigm a post request if no key is specified" do
    setup_configuration({:api_key => 'the-key', :api_secret => 'shhh'})
    stub_http(:post).should_receive(:post) do |url, data, headers|
      data.should_not include('sig=')
      SuccessResponse.blank
    end
    sender = Little::Sender.new(@configuration)
    sender.post_request(:test, {:data => '2'}, nil)  
  end
  
  it "does not sign a request if no keys are specified" do
    setup_configuration({:api_key => 'the-key2', :api_secret => 'sh2'})
    stub_http(:get).should_receive(:get) do |url, headers|
      url.should_not include('sig=')
      SuccessResponse.blank
    end
    Little::Sender.new(@configuration).get_request(:test, {:leto => 'ghanima'}, nil)  
  end
  
  it "signs a post request with the specified value" do
    setup_configuration({:api_key => 'the-key', :api_secret => 'shhh'})
    stub_http(:post).should_receive(:post) do |url, data, headers|
      data.should include('sig=b5ff522ffb6ecc97b3e9b7d43159d17a5bcca115')
      SuccessResponse.blank
    end
    Little::Sender.new(@configuration).post_request(:test, {:data => '2', :time => 1232}, [:data])  
  end
  
  it "signs a get request with the specified value" do
    setup_configuration({:api_key => 'the-key2', :api_secret => 'sh2'})
    stub_http(:get).should_receive(:get) do |url, headers|
      url.should include('sig=9609eb851b1f1882f3d7ddf1cc66290984f859f1')
      SuccessResponse.blank
    end
    Little::Sender.new(@configuration).get_request(:test, {:leto => 'ghanima', :like => 'spice'}, [:leto])
  end
  
  it "sends a post to the correct URL" do
    setup_configuration({})
    stub_http(:post).should_receive(:post) do |url, data, headers|
      url.should include('/api/v1/likes')
      SuccessResponse.blank
    end
    Little::Sender.new(@configuration).post_request(:likes, {}, nil)
  end
  
  it "sends a get to the correct URL" do
    setup_configuration({})
    stub_http(:get).should_receive(:get) do |url, headers|
      url.should include('/api/v1/tags')
      SuccessResponse.blank
    end
    Little::Sender.new(@configuration).get_request(:tags, {}, nil)
  end
  
  it "throws an exception on http error for post" do
    setup_configuration({})
    stub_http(:post).stub!(:post).and_return(ErrorResponse.new(400, '{"error": "invalid"}'))
    assert_error(400, {'error' => 'invalid'}) do
      Little::Sender.new(@configuration).post_request(:likes, {}, nil)
    end
  end
  
  it "throws an exception on http error for get" do
    setup_configuration({})
    stub_http(:post).stub!(:get).and_return(ErrorResponse.new(300, '{"blah": "tired"}'))
    assert_error(300, {'blah' => 'tired'}) do
      Little::Sender.new(@configuration).get_request(:likes, {}, nil)
    end
  end
  
  it "posts returns the data on success" do
    setup_configuration({})
    stub_http(:post).stub!(:post).and_return(SuccessResponse.new('{"way-to-go": true}'))
    Little::Sender.new(@configuration).post_request(:likes, {}, nil).should == {'way-to-go' => true}
  end
  
  it "get returns the data on success" do
    setup_configuration({})
    stub_http(:get).stub!(:get).and_return(SuccessResponse.new('{"way-to-go": true}'))
    Little::Sender.new(@configuration).get_request(:likes, {}, nil).should == {'way-to-go' => true}

  end

  
  private 
  def setup_configuration(options)
    @configuration = Little::Configuration.new
    options.each do |k,v|
      @configuration.send(:"#{k}=", v)
    end
  end
  def stub_http(method, r = nil)
    http = Net::HTTP.new(@configuration.host, @configuration.port)
    Net::HTTP.should_receive(:new).with(@configuration.host, @configuration.port).and_return(http)
    Net::HTTP.should_receive(:Proxy).with(@configuration.proxy_host, @configuration.proxy_port, @configuration.proxy_user, @configuration.proxy_pass).and_return(Net::HTTP)
    http.should_receive(method).and_return(r) unless r.nil?
    http
  end
  
  def assert_error(code, data)
    begin
      yield
      true.should be_false #must be a better way
    rescue Little::Error => e
      e.code.should == code
      e.data.should == data
    end
  end
  
  class SuccessResponse < Net::HTTPSuccess
    attr_accessor :code, :body
    
    def initialize(body)
      @code = 200
      @body = body
    end
    def[](key)
      return 'application/json'
    end
    
    def self.blank
      SuccessResponse.new('{}')
    end
  end
  
  class ErrorResponse < Net::HTTPResponse
    attr_accessor :code, :body
    
    def initialize(code, body)
      @code = code
      @body = body
    end
    def[](key)
      return 'application/json'
    end
  end
end