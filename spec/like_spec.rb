require 'spec_helper'

describe 'like' do
  it "adds a like" do
    Little.should_receive(:post).with(:likes, {:user => 'leto', :asset => 'spice'}, [:user])
    Little::Like.add('leto', 'spice')
  end
  
  it "gets whether a user liked an asset" do
    Little.should_receive(:get).with(:likes, {:user => 'leto', :asset => 'spice'}).and_return('yes')
    Little::Like.user_likes_asset('leto', 'spice').should == 'yes'
  end
  
  it "gets a user's likes" do
    Little.should_receive(:get).with(:likes, {:user => 'ghanima', :page => 2, :records => 10}).and_return('blah')
    Little::Like.user_likes('ghanima', 2, 10).should == 'blah'
  end
  
  it "gets a user's likes count" do
    Little.should_receive(:get).with(:likes, {:user => 'jessica', :count => true}).and_return(22)
    Little::Like.user_like_count('jessica').should == 22
  end

  it "gets an assets liked by'" do
    Little.should_receive(:get).with(:likes, {:asset => 'dragonballs', :count => true}).and_return(7)
    Little::Like.asset_like_count('dragonballs').should == 7
  end

end