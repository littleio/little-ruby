module Little
  class Tag
    def self.add(user, asset, type, share, data = nil)
      d = {:user => user, :asset => asset, :share => share, :type => type}
      d[:data] = data if data
      Little.post(:tags, d, [:user])
    end
    def self.sign_add(user)
      Little.sign(:tags, {:user => user})
    end
    def self.get_by_id(id, shared_only = true)
      Little.get(:tags, {:id => id}, shared_only ? nil : [:id])
    end
    def self.user_tags(user, page, records, shared_only = true)
      data = {:user => user, :page => page, :records => records}
      Little.get(:tags, data, shared_only ? nil : [:user])
    end
    def self.user_tags_for_asset(user, asset, type, page, records, shared_only = true)
      data = {:user => user, :asset => asset, :type => type, :page => page, :records => records}
      Little.get(:tags, data, shared_only ? nil : [:user, :asset, :type])
    end
    def self.user_tag_count(user, shared_only = true)
      data = {:user => user, :count => true}
      Little.get(:tags, data, shared_only ? nil : [:user])
    end
    def self.user_tag_for_asset_count(user, asset, type, shared_only = true)
      data = {:user => user, :asset => asset, :type => type, :count => true}
      Little.get(:tags, data, shared_only ? nil : [:user, :asset, :type])
    end
    def self.sign_user_tags(user)
      Little.sign(:tags, {:user => user})
    end
    def self.sign_user_tags_for_asset(user, asset, type)
      Little.sign(:tags, {:user => user, :asset => asset, :type => type})
    end
    def self.asset_tags(asset, type, page, records)
      Little.get(:tags, {:asset => asset, :type => type, :page => page, :records => records})
    end
    def self.asset_tag_count(asset, type)
      Little.get(:tags, {:asset => asset, :type => type, :count => true})
    end
  end
end