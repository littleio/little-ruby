require 'spec_helper'

describe 'tag' do
  it "adds a tag with no data" do
    Little.should_receive(:post).with(:tags, {:user => 'leto', :asset => 'spice', :type => 3, :share => true}, [:user])
    Little::Tag.add('leto', 'spice', 3, true)
  end
  
  it "adds a tag with data" do
    Little.should_receive(:post).with(:tags, {:user => 'jessica', :asset => 'paul', :type => 4, :share => false, :data => 'abc|123'}, [:user])
    Little::Tag.add('jessica', 'paul', 4, false, 'abc|123')
  end
  
  it "signs the add" do
    Little::Tag.sign_add('jessica').should == '647c27ea75be9d4720239b07d732fc71377973e5'
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
    Little.should_receive(:get).with(:tags, {:user => 'leto', :asset => 'spice', :type => 22, :page => 4, :records => 5}, nil).and_return('yes')
    Little::Tag.user_tags('leto', 4, 5, true, 'spice', 22).should == 'yes'
  end

  it "gets all of a user's tags for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'yay', :asset => 123, :type => 12, :page => 1, :records => 10}, [:user, :asset, :type]).and_return('no')
    Little::Tag.user_tags('yay', 1, 10, false, 123, 12).should == 'no'
  end
  
  it "gets a user's public tag count" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :count => true}, nil).and_return('no')
    Little::Tag.user_tag_count('user', true).should == 'no'
  end

  it "gets a user's public tag count for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :asset => 'ass', :type => 3, :count => true}, nil).and_return('no')
    Little::Tag.user_tag_count('user', true, 'ass', 3).should == 'no'
  end
  
  it "gets a user's complete tag count" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :count => true}, [:user]).and_return('no')
    Little::Tag.user_tag_count('user', false).should == 'no'
  end

  it "gets a user's complete tag for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :asset => 'abc', :type => 1, :count => true}, [:user, :asset, :type]).and_return('no')
    Little::Tag.user_tag_count('user', false, 'abc', 1).should == 'no'
  end
  
  it "gets the tags for an asset" do
    Little.should_receive(:get).with(:tags, {:asset => 'grapes', :type => 3, :page => 1, :records => 5}).and_return('im an idiot')
    Little::Tag.asset_tags('grapes', 3, 1, 5).should == 'im an idiot'
  end
  
  it "gets the tag count for an asset" do
    Little.should_receive(:get).with(:tags, {:asset => 'grapes', :type => 11, :count => true}).and_return(33)
    Little::Tag.asset_tag_count('grapes', 11).should == 33
  end
  
  it "gets a tag by id for shared only" do
    Little.should_receive(:get).with(:tags, {:id => 123}, nil).and_return('abc')
    Little::Tag.get_by_id(123).should == 'abc'
  end
  
  it "gets a tag by id for non shared" do
    Little.should_receive(:get).with(:tags, {:id => 3}, [:id]).and_return('a')
    Little::Tag.get_by_id(3, false).should == 'a'
  end
  
  it "signs the user tags without asset" do
    Little::Tag.sign_user_tags('paul').should == '779534cdf94c41a246fdb573c4e3237f5b21e005'
  end
  
  it "signs the user tags with an asset" do
    Little::Tag.sign_user_tags('goku', 'power', 9000).should == '8a6fdd500e51057e0ab2f1a9b10f3902df12faff'
  end

end