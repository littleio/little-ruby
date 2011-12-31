require 'spec_helper'

describe 'tag' do
  it "adds a tag with no data" do
    Little.should_receive(:post).with(:tags, {:user => 'leto', :asset => 'spice', :type => 3, :share => true}, [:user, :asset, :type])
    Little::Tag.add('leto', 'spice', 3, true)
  end
  
  it "adds a tag with data" do
    Little.should_receive(:post).with(:tags, {:user => 'jessica', :asset => 'paul', :type => 4, :share => false, :data => 'abc|123'}, [:user, :asset, :type])
    Little::Tag.add('jessica', 'paul', 4, false, 'abc|123')
  end
  
  it "signs the add" do
    Little::Tag.sign_add('jessica', 'ass', 1000).should == 'd784120a247d022679d6c839c5a9de9d55d9149e'
  end
  
  it "deletes a tag" do
    Little.should_receive(:delete).with(:tags, {:id => 'w00t'}, [:id])
    Little::Tag.delete('w00t')
  end
  
  it "signs the delete" do
    Little::Tag.sign_delete('booo').should == 'b8b30d7db292d3eb556dca4b5a7371634084ad21'
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
    Little::Tag.user_tags_for_asset('leto', 'spice', 22, 4, 5, true).should == 'yes'
  end

  it "gets all of a user's tags for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'yay', :asset => 123, :type => 12, :page => 1, :records => 10}, [:user, :asset, :type]).and_return('no')
    Little::Tag.user_tags_for_asset('yay', 123, 12, 1, 10, false).should == 'no'
  end
  
  it "gets a user's public tag count" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :count => true}, nil).and_return('no')
    Little::Tag.user_tag_count('user', true).should == 'no'
  end

  it "gets a user's public tag count for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :asset => 'ass', :type => 3, :count => true}, nil).and_return('no')
    Little::Tag.user_tag_for_asset_count('user', 'ass', 3, true).should == 'no'
  end
  
  it "gets a user's complete tag count" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :count => true}, [:user]).and_return('no')
    Little::Tag.user_tag_count('user', false).should == 'no'
  end

  it "gets a user's complete tag for an asset" do
    Little.should_receive(:get).with(:tags, {:user => 'user', :asset => 'abc', :type => 1, :count => true}, [:user, :asset, :type]).and_return('no')
    Little::Tag.user_tag_for_asset_count('user', 'abc', 1, false).should == 'no'
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
    Little::Tag.sign_user_tags_for_asset('goku', 'power', 9000).should == '8a6fdd500e51057e0ab2f1a9b10f3902df12faff'
  end

end