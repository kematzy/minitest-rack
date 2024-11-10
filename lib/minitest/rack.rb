# frozen_string_literal: true

require 'minitest'
require 'minitest/rack/version'
require 'rack/test'

# reopening to add validations functionality
module Minitest
  # Module containing test assertions for HTTP response bodies
  module Assertions
    def assert_body(res)
      msg = "Expected response to be '#{res}', but was '#{last_response.body}'"

      assert_equal(last_response.body, res, msg)
    end
    # /module Assertions

    # add support for Spec syntax
    module Expectations
      # TODO: figure out how to use and test this
      # infect_an_assertion :assert_body, :must_have_body, :reverse
    end
  end
end

require 'minitest/rack/headers'
