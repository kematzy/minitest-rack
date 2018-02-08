require "minitest"
require "minitest/rack/version"
require "rack/test"

module Minitest
  module Rack
    module Body
      module Assertions

        # 
        # 
        # 
        def assert_body(res)
          assert_equal(last_response.body, res, "Expected response to be '#{res}', but was '#{last_response.body}'")
        end
      
      end
    end
  end
end

# include the assertions into Minitest
class Minitest::Test
  include Minitest::Rack::Body::Assertions
end
