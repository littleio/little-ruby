module Little
  class Tag
    def self.add(user, asset, share, data = nil)
      d = {:user => user, :asset => asset, :share => share}
      d[:data] = data if data
      Little.post(:tags, d, [:user])
    end
    def self.get_by_id(id, shared_only = true)
      Little.get(:tags, {:id => id}, shared_only ? nil : [:id])
    end
    def self.user_tags(user, page, records, shared_only = true, asset = nil)
      data = {:user => user, :page => page, :records => records}
      data[:asset] = asset if asset
      Little.get(:tags, data, keys_to_sign_with(!asset.nil?, shared_only))
    end
    def self.user_tag_count(user, shared_only = true, asset = nil)
      data = {:user => user, :count => true}
      data[:asset] = asset if asset
      Little.get(:tags, data, keys_to_sign_with(!asset.nil?, shared_only))
    end
    def self.asset_tags(asset, page, records)
      Little.get(:tags, {:asset => asset, :page => page, :records => records})
    end
    def self.asset_tag_count(asset)
      Little.get(:tags, {:asset => asset, :count => true})
    end
    
    private
    def self.keys_to_sign_with(has_asset, shared_only)
      return nil if shared_only
      keys = [:user]
      keys << :asset if has_asset
      keys
    end
  end
end