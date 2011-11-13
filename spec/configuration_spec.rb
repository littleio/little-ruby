require 'spec_helper'

describe 'configurations' do
  it "provide default values" do
    assert_default_config :host, 'api.little.io'
    assert_default_config :secure, true
    assert_default_config :http_open_timeout, 2
    assert_default_config :http_read_timeout, 5
    assert_default_is_nil :api_key, :api_secret, :proxy_host, :proxy_port, :proxy_user, :proxy_pass
  end
 
  it "allows values to be set" do
    assert_value_set :host, 'something.else.com'
    assert_value_set :secure, false
    assert_value_set :http_open_timeout, 10
    assert_value_set :http_read_timeout, 15
    assert_value_set :api_key, '12312312p98sldkj123'
    assert_value_set :api_secret, '12kjd923kaks'
    assert_value_set :proxy_host, 'secret.proxy.com'
    assert_value_set :proxy_port, 8080
    assert_value_set :proxy_user, 'admin'
    assert_value_set :proxy_pass, 'password'
  end
  
  it "uses a default port based on the secure setting" do
    config = Little::Configuration.new
    config.secure = true
    config.port.should == 443
    
    config.secure = false
    config.port.should == 80
  end
  
  it "uses the specified port" do
    config = Little::Configuration.new
    config.port = 3000
    config.port.should == 3000
    config.secure = false
    config.port.should == 3000
  end
 
  private
  def assert_default_config(option, value)
    Little::Configuration.new.send(option).should == value 
  end
  def assert_default_is_nil(*options)
    options.each do |option|
      Little::Configuration.new.send(option).should be_nil
    end
  end
  def assert_value_set(option, value)
    config = Little::Configuration.new
    config.send(:"#{option}=", value)
    config.send(option).should == value
  end
end