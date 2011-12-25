require 'spec_helper'

describe 'notification' do
  it "gets the notification" do
    Little.should_receive(:get).with(:notifications, {:user => 'leto', :type => 44})
    Little::Notification.get('leto', 44)
  end
  
  it "sends the response" do
    Little.should_receive(:post).with(:notifications, {:user => 'paul', :notification => "324343", :response => 4}, [:user, :notification])
    Little::Notification.respond('paul', "324343", 4)
  end
  
  it "signs the response" do
    Little::Notification.sign_respond('vegeta', "1233").should == '5143b797c148794bbbb4897538f00d5925ee45fa'
  end
end