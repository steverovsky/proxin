$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "proxin"

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.order = :rand
end
