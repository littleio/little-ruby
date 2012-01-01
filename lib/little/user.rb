module Little
  # log and retrieve login attempts
  class User
    # adds a login attempt
    # @param [String] user the user who attempted to login
    # @param [String] ip the user's ip address (use request.remote_ip in rails)
    # @param [bool] ok whether or not the login was successful
    # @return [Hash] the number of failed attempts in the last 0.5, 1, 3 and 5 minutes
    def self.login_attempt(user, ip, ok)
      Little.post(:users, {:user => user, :ip => ip, :ok => ok}, [:user, :ip, :ok], 'attempt')
    end
    
    # gets the previous (2nd last) successful login attempt
    def self.previous_successful_attempt(user)
      Little.get(:users, {:user => user}, [:user], 'attempts')
    end
    
    # gets the login attempts for the user
    # @param [String] user the user who attempted to login
    # @param [int] count the number of past attempts to retrieve
    def self.attempts(user, count = 1)
      Little.get(:users, {:user => user, :count => count}, [:user], 'attempts')
    end
    
    # generates a signature for getting attempts(useful when using the javascript library)
    def self.sign_attempts(user)
      Little.sign(:users, {:user => user})
    end
  end
end