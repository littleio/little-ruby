module Little
  # retrieve and repond to notifications
  class Notification
    # gets the notification for a user and type
    # @param [String] user the user to get the notification for
    # @param [int] type the type of notifiation to get
    # @return [Hash] containing the notification id and body, nil if the type is valid or if the user has already responded
    def self.get(user, type)
      Little.get(:notifications, {:user => user, :type => type})
    end
    
    # responds to a particular notification
    # @param [String] user the user responding to the notificaiton
    # @param [String] notificaiton_id the id of the notificaiton
    # @param [int] response the user's response
    def self.respond(user, notification_id, response)
      Little.post(:notifications, {:user => user, :notification => notification_id, :response => response}, [:user, :notification])
    end
    
    # generates a signature for sending a response(useful when using the javascript library)
    def self.sign_respond(user, notification_id)
      Little.sign(:notification, {:user => user, :notification => notification_id})
    end
  end
end