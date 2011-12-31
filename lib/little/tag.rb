module Little
  # add, delete and retrieve tags by user or assets
  class Tag
    # adds a tag for a user to an asset
    # @param [String] user the user who likes the asset
    # @param [String] asset the asset being liked
    # @param [int] type the type of asset
    # @param [bool] share whether to share this tag or not
    # @param [String] arbitrary data to save with the tag
    def self.add(user, asset, type, share, data = nil)
      d = {:user => user, :asset => asset, :share => share, :type => type}
      d[:data] = data if data
      Little.post(:tags, d, [:user, :asset, :type])
    end
    
    # generates a signature for adding a tag (useful when using the javascript library)
    def self.sign_add(user, asset, type)
      Little.sign(:tags, {:user => user, :asset => asset, :type => type})
    end
    
    # removes a tag for a user to an asset
    # @param [String] id the tag's id
    def self.delete(id)
      Little.delete(:tags, {:id => id}, [:id])
    end
    
    # generates a signature for deleting a tag (useful when using the javascript library)
    def self.sign_delete(id)
      Little.sign(:tags, {:id => id})
    end
    
    # gets a tag by id
    # @param [String] id the tag's id
    # @param [bool] shared_only only get the tag if it's shared
    def self.get_by_id(id, shared_only = true)
      Little.get(:tags, {:id => id}, shared_only ? nil : [:id])
    end
    
    # generates a signature for getting a tag by id (useful when using the javascript library)
    def self.sign_get_by_id(id)
      Little.sign(:tags, {:id => id})
    end
    
    # gets all the tags for a user
    def self.for_user(user, page, records, shared_only = true)
      data = {:user => user, :page => page, :records => records}
      Little.get(:tags, data, shared_only ? nil : [:user])
    end
    
    # gets all the assets liked for a user for a specific asset
    def self.for_user_and_asset(user, asset, type, page, records, shared_only = true)
      data = {:user => user, :asset => asset, :type => type, :page => page, :records => records}
      Little.get(:tags, data, shared_only ? nil : [:user, :asset, :type])
    end
    
    # gets the number of tags for a user
    def self.for_user_count(user, shared_only = true)
      data = {:user => user, :count => true}
      Little.get(:tags, data, shared_only ? nil : [:user])
    end
    
    # gets all the of tags for a user for a specific asset
    def self.for_user_and_asset_count(user, asset, type, shared_only = true)
      data = {:user => user, :asset => asset, :type => type, :count => true}
      Little.get(:tags, data, shared_only ? nil : [:user, :asset, :type])
    end
    
    # generates a signature for getting a tags for a user (useful when using the javascript library)
    def self.sign_for_user(user)
      Little.sign(:tags, {:user => user})
    end
    
    # generates a signature for getting a for a user for a specific asset (useful when using the javascript library)
    def self.sign_for_user_and_asset(user, asset, type)
      Little.sign(:tags, {:user => user, :asset => asset, :type => type})
    end
    
    # gets all the shared tags for a specific asset
    def self.for_asset(asset, type, page, records)
      Little.get(:tags, {:asset => asset, :type => type, :page => page, :records => records})
    end
    
    # gets the number of shared tags for a specific asset
    def self.for_asset_count(asset, type)
      Little.get(:tags, {:asset => asset, :type => type, :count => true})
    end
  end
end