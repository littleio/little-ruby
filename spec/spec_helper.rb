$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), '..', 'lib/litle/*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'support/*.rb')].each {|file| require file }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.mock_with :rspec
end