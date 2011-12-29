require 'spec_helper'

describe 'like' do
  it "adds a like" do
    Little.should_receive(:post).with(:likes, {:user => 'leto', :asset => 'spice', :type => 3}, [:user])
    Little::Like.add('leto', 'spice', 3)
  end
  
  it "deletes a like" do
    Little.should_receive(:delete).with(:likes, {:user => 'jessica', :asset => 'baron', :type => 5}, [:user, :asset, :type])
    Little::Like.delete('jessica', 'baron', 5)
  end
  
  it "signs the add" do
    Little::Like.sign_add('vegeta').should == 'f3b82990a83160569b8f5cd8866eebb3593a1b1e'
  end
  
  it "gets whether a user liked an asset" do
    Little.should_receive(:get).with(:likes, {:user => 'leto', :asset => 'spice', :type => 11}).and_return('yes')
    Little::Like.user_likes_asset('leto', 'spice', 11).should == 'yes'
  end
  
  it "gets a user's likes" do
    Little.should_receive(:get).with(:likes, {:user => 'ghanima', :page => 2, :records => 10}).and_return('blah')
    Little::Like.user_likes('ghanima', 2, 10).should == 'blah'
  end
  
  it "gets a user's likes count" do
    Little.should_receive(:get).with(:likes, {:user => 'jessica', :count => true}).and_return(22)
    Little::Like.user_like_count('jessica').should == 22
  end

  it "gets an assets liked by" do
    Little.should_receive(:get).with(:likes, {:asset => 'goku', :type => 2, :page => 4, :records => 10}).and_return(6)
    Little::Like.asset_liked_by('goku', 2, 4, 10).should == 6
  end
  
  it "gets an assets liked count" do
    Little.should_receive(:get).with(:likes, {:asset => 'dragonballs', :type => 2, :count => true}).and_return(7)
    Little::Like.asset_like_count('dragonballs', 2).should == 7
  end
  
  it "gets assets by type" do
    Little.should_receive(:get).with(:likes, {:type => 77, :page => 2, :records => 11}).and_return(6)
    Little::Like.by_type(77, 2, 11).should == 6
  end
  
  it "asset count by type'" do
    Little.should_receive(:get).with(:likes, {:type => 'worms', :count => true}).and_return(5)
    Little::Like.by_type_count('worms').should == 5
  end

end