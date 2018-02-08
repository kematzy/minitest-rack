require "rack/test"
require "minitest/rack"
require "minitest/rack/headers"
require "minitest/rack/json"
require "minitest/rack/status"

class Minitest::Test
  include Rack::Test::Methods
end
