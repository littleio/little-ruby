require 'spec_helper'

describe 'asset' do
  it "votes for an asset" do
    Little.should_receive(:post).with(:assets, {:user => 'leto', :asset => 'spice', :type => 3, :vote => true}, [:user, :asset, :type], 'vote')
    Little::Asset.vote('leto', 'spice', 3, :up)
  end
  
  it "rates an asset" do
    Little.should_receive(:post).with(:assets, {:user => 'jessica', :asset => 'baron', :type => 5, :rate => -20}, [:user, :asset, :type], 'rate')
    Little::Asset.rate('jessica', 'baron', 5, -20)
  end
  
  it "signs the vote" do
    Little::Asset.sign_vote('vegeta', 'balls', 7).should == '955595f8b8cc1cf3b9bd7f8481d965d442d2fe81'
  end
  
  it "signs the rate" do
    Little::Asset.sign_rate('gohan', 'dbz', 4).should == '288235020de2bec1fbf50f9ee758cfc6028a1943'
  end
  
  it "gets aspecific user asset" do
    Little.should_receive(:get).with(:assets, {:user => 'leto', :asset => 'spice', :type => 11}).and_return('yes')
    Little::Asset.user_asset('leto', 'spice', 11).should == 'yes'
  end
  
  it "gets whether a user's assets" do
    Little.should_receive(:get).with(:assets, {:user => 'leto', :page => 11, :records => 1, :vote => nil, :rate => nil}).and_return('yes')
    Little::Asset.for_user('leto', 11, 1).should == 'yes'
  end
  
  it "gets a user's asset count" do
    Little.should_receive(:get).with(:assets, {:user => 'jessica', :count => true, :vote => nil, :rate => nil}).and_return(22)
    Little::Asset.for_user_count('jessica').should == 22
  end
  
  it "gets whether a user asset with filters" do
    Little.should_receive(:get).with(:assets, {:user => 'leto', :page => 5, :records => 7, :vote => true, :rate => false}).and_return('yes')
    Little::Asset.for_user('leto', 5, 7, true, false).should == 'yes'
  end
  
  it "gets a user's asset count with filters" do
    Little.should_receive(:get).with(:assets, {:user => 'jessica', :count => true, :vote => false, :rate => true}).and_return(22)
    Little::Asset.for_user_count('jessica', false, true).should == 22
  end
  
  it "gets an asset's users" do
    Little.should_receive(:get).with(:assets, {:asset => 'goku', :type => 2, :page => 4, :records => 10, :vote => nil, :rate => nil}).and_return(6)
    Little::Asset.for_asset('goku', 2, 4, 10).should == 6
  end
  
  it "gets an asset's user count" do
    Little.should_receive(:get).with(:assets, {:asset => 'dragonballs', :type => 2, :count => true, :vote => nil, :rate => nil}).and_return(7)
    Little::Asset.for_asset_count('dragonballs', 2).should == 7
  end
  
  it "gets an asset's users with filters" do
    Little.should_receive(:get).with(:assets, {:asset => 'goku', :type => 2, :page => 4, :records => 10, :vote => false, :rate => true}).and_return(6)
    Little::Asset.for_asset('goku', 2, 4, 10, false, true).should == 6
  end
  
  it "gets an asset's user count with filters" do
    Little.should_receive(:get).with(:assets, {:asset => 'dragonballs', :type => 2, :count => true, :vote => true, :rate => false}).and_return(7)
    Little::Asset.for_asset_count('dragonballs', 2, true, false).should == 7
  end
  
  it "gets best rated assets" do
    Little.should_receive(:get).with(:assets, {:type => 77, :page => 2, :records => 11}, nil, 'by_rate').and_return(6)
    Little::Asset.highest_rated(77, 2, 11).should == 6
  end
  
  it "gets most voted asset" do
    Little.should_receive(:get).with(:assets, {:type => 77, :page => 2, :records => 11}, nil, 'by_vote').and_return(6)
    Little::Asset.most_votes(77, 2, 11).should == 6
  end
  
  it "asset count by type'" do
    Little.should_receive(:get).with(:assets, {:type => 10}, nil, 'count').and_return(5)
    Little::Asset.count_by_type(10).should == 5
  end

end