module Little
  class Tag
    def self.add(user, asset, type, share, data = nil)
      d = {:user => user, :asset => asset, :share => share, :type => type}
      d[:data] = data if data
      Little.post(:tags, d, [:user])
    end
    def self.get_by_id(id, shared_only = true)
      Little.get(:tags, {:id => id}, shared_only ? nil : [:id])
    end
    def self.user_tags(user, page, records, shared_only = true, asset = nil, type = 0)
      data = {:user => user, :page => page, :records => records}
      if asset
        data[:asset] = asset 
        data[:type] = type
      end
      Little.get(:tags, data, keys_to_sign_with(!asset.nil?, shared_only))
    end
    def self.user_tag_count(user, shared_only = true, asset = nil, type = 0)
      data = {:user => user, :count => true}
      if asset
        data[:asset] = asset 
        data[:type] = type
      end
      Little.get(:tags, data, keys_to_sign_with(!asset.nil?, shared_only))
    end
    def self.asset_tags(asset, type, page, records)
      Little.get(:tags, {:asset => asset, :type => type, :page => page, :records => records})
    end
    def self.asset_tag_count(asset, type)
      Little.get(:tags, {:asset => asset, :type => type, :count => true})
    end
    
    private
    def self.keys_to_sign_with(has_asset, shared_only)
      return nil if shared_only
      keys = [:user]
      if has_asset
        keys << :asset
        keys << :type
      end
      keys
    end
  end
end