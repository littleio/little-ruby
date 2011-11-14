require 'spec_helper'

describe 'like' do
  it "adds a like" do
    Little.should_receive(:post).with(:likes, {:user => 'leto', :asset => 'spice'}, [:user])
    Little::Like.add('leto', 'spice')
  end
end