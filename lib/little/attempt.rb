module Little
  # log and retrieve login attempts
  class Attempt
    # adds a login attempt
    # @param [String] user the user who attempted to login
    # @param [String] ip the user's ip address (use request.remote_ip in rails)
    # @param [bool] ok whether or not the login was successful
    # @return [Hash] the number of failed attempts in the last 0.5, 1, 3 and 5 minutes
    def self.add(user, ip, ok)
      Little.post(:attempts, {:user => user, :ip => ip, :ok => ok}, [:user, :ip, :ok])
    end
    
    # gets the previous (2nd last) successful login attempt
    def self.get_previous_successful(user)
      Little.get(:attempts, {:user => user}, [:user])
    end
    
    # gets the login attempts for theu ser
    # @param [String] user the user who attempted to login
    # @param [int] count the number of past attempts to retrieve
    def self.get(user, count = 1)
      Little.get(:attempts, {:user => user, :count => count}, [:user])
    end
    
    # generates a signature for getting attempts(useful when using the javascript library)
    def self.sign_get(user)
      Little.sign(:attempts, {:user => user})
    end
  end
end