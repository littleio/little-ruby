module Little
  class Like
    def self.add(user, asset)
      Little.post('likes', {:user => user, :asset => asset}, [:user])
    end
  end
end