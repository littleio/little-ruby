module Little
  class Attempt
    def self.add(user, ip, ok)
      Little.post(:attempts, {:user => user, :ip => ip, :ok => ok}, [:user, :ip, :ok])
    end
    def self.get(user, count = 1)
      Little.get(:attempts, {:user => user, :count => count}, [:user])
    end
    def self.sign_get(user)
      Little.sign(:attempts, {:user => user})
    end
  end
end