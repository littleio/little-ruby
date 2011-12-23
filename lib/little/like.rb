module Little
  class Like
    def self.add(user, asset, type)
      Little.post(:likes, {:user => user, :asset => asset, :type => type}, [:user])
    end
    def self.user_likes_asset(user, asset, type)
      Little.get(:likes, {:user => user, :asset => asset, :type => type})
    end
    def self.user_likes(user, page, records)
      Little.get(:likes, {:user => user, :page => page, :records => records})
    end
    def self.user_like_count(user)
      Little.get(:likes, {:user => user, :count => true})
    end
    def self.asset_liked_by(asset, type, page, records)
      Little.get(:likes, {:asset => asset, :type => type, :page => page, :records => records})
    end
    def self.asset_like_count(asset, type)
      Little.get(:likes, {:asset => asset, :type => type, :count => true})
    end
    def self.by_type(type, page, records)
      Little.get(:likes, {:type => type, :page => page, :records => records})
    end
    def self.by_type_count(type)
      Little.get(:likes, {:type => type, :count => true})
    end
  end
end