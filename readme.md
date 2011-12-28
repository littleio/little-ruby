# little.io Ruby Library
This is a ruby driver for the <http://little.io> services.

# Installation

	gem install little

# Configuration
On startup, you'll want to setup your api key and secret:

	Little.configure do |config|
	  config.api_key = 'KEY'
	  config.api_secret = 'SECRET'
	end

Other available options are (with default):

	host (api.little.io)
	port (443)
	secure (true)
	http_open_timeout (5)
	http_read_timeout (5)
	proxy_host (nil)
	proxy_pass (nil)
	proxy_port (nil)
	proxy_user (nil)

# Errors
Most errors will be raised as an instance of `Little::Error`

# Signing
The driver will automatically include the signature. However, signing helpers are available for use with the [https://github.com/littleio/little-javascript](JavaScript driver). 

# Usage
Once configured the services can be invoked via various methods:

	Little::Attempt.add(user, request.remote_ip, true)