require 'spec_helper'

describe 'attempt' do
  it "sends a failed attempt request" do
    Little.should_receive(:post).with(:users, {:user => 'leto', :ip => '1.1.1.1', :ok => false}, [:user, :ip, :ok], 'attempt')
    Little::User.login_attempt('leto', '1.1.1.1', false)
  end
  
  it "sends a good attempt request" do
    Little.should_receive(:post).with(:users, {:user => 'paul', :ip => '2.2.2.2', :ok => true}, [:user, :ip, :ok], 'attempt')
    Little::User.login_attempt('paul', '2.2.2.2', true)
  end
  
  it "gets the last attempt" do
    Little.should_receive(:get).with(:users, {:user => 'jessica', :count => 1}, [:user], 'attempts')
    Little::User.attempts('jessica')
  end
  
  it "gets the previous successful attempt" do
    Little.should_receive(:get).with(:users, {:user => 'goku'}, [:user], 'attempts')
    Little::User.previous_successful_attempt('goku')
  end
  
  it "gets a specified number of past attempts" do
    Little.should_receive(:get).with(:users, {:user => 'duke', :count => 10}, [:user], 'attempts')
    Little::User.attempts('duke', 10)
  end
  
  it "signs the get" do
    Little::User.sign_attempts('abc123').should == '7f7243c4fe07cf9aca3ef0a12ec5ed951e85010f'
  end
end