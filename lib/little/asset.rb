module Little
  # add, delete and retrieve likes by user or assets
  class Asset
    # votes for an asset
    # @param [String] user the user who likes the asset
    # @param [String] asset the asset being liked
    # @param [int] type the type of asset
    # params [symbol] up_or_down either :up or :down
    def self.vote(user, asset, type, up_or_down)
      Little.post(:assets, {:user => user, :asset => asset, :type => type, :vote => up_or_down == :up}, [:user, :asset, :type], 'vote')
    end
    
    # generates a signature for voting on an asset (useful when using the javascript library)
    def self.sign_vote(user, asset, type)
      Little.sign(:assets, {:user => user, :asset => asset, :type => type})
    end
    
    # rates an asset
    # @param [String] user the user who likes the asset
    # @param [String] asset the asset being liked
    # @param [int] type the type of asset
    # params [int] rating the rating
    def self.rate(user, asset, type, rating)
      Little.post(:assets, {:user => user, :asset => asset, :type => type, :rate => rating}, [:user, :asset, :type], 'rate')
    end
    
    # generates a signature for rating an asset (useful when using the javascript library)
    def self.sign_rate(user, asset, type)
      Little.sign(:assets, {:user => user, :asset => asset, :type => type})
    end
    
    # does the user like the asset
    def self.user_asset(user, asset, type)
      Little.get(:assets, {:user => user, :asset => asset, :type => type})
    end
    
    # gets all the user's assets
    # params [bool] vote true or false to get assets voted for or against, or nil to get all
    # params [bool] rated_only true or false to get assets the user rated, or nil to get all
    def self.user_assets(user, page, records, vote = nil, rated_only = nil)
      Little.get(:assets, {:user => user, :page => page, :records => records, :vote => vote, :rate => rated_only})
    end
    
    # gets the number of assets the user likes
    def self.user_asset_count(user, vote = nil, rated_only = nil)
      Little.get(:assets, {:user => user, :count => true, :vote => vote, :rate => rated_only})
    end
    
    # gets all the users who like an asset
    def self.assets(asset, type, page, records, vote = nil, rated_only = nil)
      Little.get(:assets, {:asset => asset, :type => type, :page => page, :records => records, :vote => vote, :rate => rated_only})
    end
    
    # gets the number of users who like an asset
    def self.asset_count(asset, type, vote = nil, rated_only = nil)
      Little.get(:assets, {:asset => asset, :type => type, :count => true, :vote => vote, :rate => rated_only})
    end
    
    # gets the assets liked by type, ordered by number of likes (desc)
    def self.highest_rated(type, page, records)
      Little.get(:assets, {:type => type, :page => page, :records => records}, nil, 'by_rate')
    end

    # gets the assets liked by type, ordered by number of likes (desc)
    def self.most_votes(type, page, records)
      Little.get(:assets, {:type => type, :page => page, :records => records}, nil, 'by_vote')
    end
    
    # gets the number of assets for a type
    def self.count_by_type(type)
      Little.get(:assets, {:type => type, :count => true}, nil, 'count')
    end
  end
end