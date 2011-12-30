require 'spec_helper'

describe 'attempt' do
  it "sends a failed attempt request" do
    Little.should_receive(:post).with(:attempts, {:user => 'leto', :ip => '1.1.1.1', :ok => false}, [:user, :ip, :ok])
    Little::Attempt.add('leto', '1.1.1.1', false)
  end
  
  it "sends a good attempt request" do
    Little.should_receive(:post).with(:attempts, {:user => 'paul', :ip => '2.2.2.2', :ok => true}, [:user, :ip, :ok])
    Little::Attempt.add('paul', '2.2.2.2', true)
  end
  
  it "gets the last attempt" do
    Little.should_receive(:get).with(:attempts, {:user => 'jessica', :count => 1}, [:user])
    Little::Attempt.get('jessica')
  end
  
  it "gets the previous successful attempt" do
    Little.should_receive(:get).with(:attempts, {:user => 'goku'}, [:user])
    Little::Attempt.get_previous_successful('goku')
  end
  
  it "gets a specified number of past attempts" do
    Little.should_receive(:get).with(:attempts, {:user => 'duke', :count => 10}, [:user])
    Little::Attempt.get('duke', 10)
  end
  
  it "signs the get" do
    Little::Attempt.sign_get('abc123').should == 'fa0a9cea177651eaf51efc0faff57fdb0d70b2ea'
  end
end