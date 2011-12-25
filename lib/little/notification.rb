module Little
  class Notification
    def self.get(user, type)
      Little.get(:notifications, {:user => user, :type => type})
    end
    def self.respond(user, notification_id, response)
      Little.post(:notifications, {:user => user, :notification => notification_id, :response => response}, [:user, :notification])
    end
    def self.sign_respond(user, notification_id)
      Little.sign(:notification, {:user => user, :notification => notification_id})
    end
  end
end