require 'spec_helper'

describe 'tag' do
  it "adds a tag with no data" do
    Little.should_receive(:post).with(:tags, {:user => 'leto', :asset => 'spice', :share => true}, [:user])
    Little::Tag.add('leto', 'spice', true)
  end
  
  it "adds a tag with data" do
    Little.should_receive(:post).with(:tags, {:user => 'jessica', :asset => 'paul', :share => false, :data => 'abc|123'}, [:user])
    Little::Tag.add('jessica', 'paul', false, 'abc|123')
  end
  
  it "gets a user's publis tags" do
    Little.should_receive(:get).with(:tags, {:user => 'leto', :page => 4, :records => 5}, nil).and_return('yes')
    Little::Tag.user_tags('leto', 4, 5, true).should == 'yes'
  end
  
  it "gets all of a user's tags" do
    Little.should_receive(:get).with(:tags, {:user => 'leto', :page => 4, :records => 5}, [:user]).and_return('yes')
    Little::Tag.user_tags('leto', 4, 5, false).should == 'yes'
  end
  
  it "gets a user's public tags for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'leto', :asset => 'spice', :page => 4, :records => 5}, nil).and_return('yes')
    Little::Tag.user_tags('leto', 4, 5, true, 'spice').should == 'yes'
  end

  it "gets all of a user's tags for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'yay', :asset => 123, :page => 1, :records => 10}, [:user, :asset]).and_return('no')
    Little::Tag.user_tags('yay', 1, 10, false, 123).should == 'no'
  end
  
  it "gets a user's public tag count" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :count => true}, nil).and_return('no')
    Little::Tag.user_tag_count('user', true).should == 'no'
  end

  it "gets a user's public tag count for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :asset => 'ass', :count => true}, nil).and_return('no')
    Little::Tag.user_tag_count('user', true, 'ass').should == 'no'
  end
  
  it "gets a user's complete tag count" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :count => true}, [:user]).and_return('no')
    Little::Tag.user_tag_count('user', false).should == 'no'
  end

  it "gets a user's complete tag for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :asset => 'abc', :count => true}, [:user, :asset]).and_return('no')
    Little::Tag.user_tag_count('user', false, 'abc').should == 'no'
  end
  
  it "gets the tags for an asset" do
    Little.should_receive(:get).with(:tags, {:asset => 'grapes', :page => 1, :records => 5}).and_return('im an idiot')
    Little::Tag.asset_tags('grapes', 1, 5).should == 'im an idiot'
  end
  
  it "gets the tag count for an asset" do
    Little.should_receive(:get).with(:tags, {:asset => 'grapes', :count => true}).and_return(33)
    Little::Tag.asset_tag_count('grapes').should == 33
  end


end