module Little
  # add, delete and retrieve likes by user or assets
  class Like
    # adds a like for a user to an asset
    # @param [String] user the user who likes the asset
    # @param [String] asset the asset being liked
    # @param [int] type the type of asset
    def self.add(user, asset, type)
      Little.post(:likes, {:user => user, :asset => asset, :type => type}, [:user])
    end
    
    # generates a signature for adding a like (useful when using the javascript library)
    def self.sign_add(user)
      Little.sign(:likes, {:user => user})
    end
    
    # removes a like for a user to an asset
    # @param [String] user the user who no longer likes the asset
    # @param [String] asset the asset being unliked
    # @param [int] type the type of asset
    def self.delete(user, asset, type)
      Little.delete(:likes, {:user => user, :asset => asset, :type => type}, [:user, :asset, :type])
    end
    
    # generates a signature for deleting a like (useful when using the javascript library)
    # @param [String] user the user who no longr likes the asset
    def self.sign_delete(user, asset, type)
      Little.sign(:likes, {:user => user, :asset => asset, :type => type})
    end
    
    # does the user like the asset
    def self.user_likes_asset(user, asset, type)
      Little.get(:likes, {:user => user, :asset => asset, :type => type})
    end
    
    # gets all the assets liked by the user
    def self.user_likes(user, page, records)
      Little.get(:likes, {:user => user, :page => page, :records => records})
    end
    
    # gets the number of assets the user likes
    def self.user_like_count(user)
      Little.get(:likes, {:user => user, :count => true})
    end
    
    # gets all the users who like an asset
    def self.asset_liked_by(asset, type, page, records)
      Little.get(:likes, {:asset => asset, :type => type, :page => page, :records => records})
    end
    
    # gets the number of users who like an asset
    def self.asset_like_count(asset, type)
      Little.get(:likes, {:asset => asset, :type => type, :count => true})
    end
    
    # gets the assets liked by type, ordered by number of likes (desc)
    def self.by_type(type, page, records)
      Little.get(:likes, {:type => type, :page => page, :records => records})
    end
    
    # gets the number of assets for a type
    def self.by_type_count(type)
      Little.get(:likes, {:type => type, :count => true})
    end
  end
end