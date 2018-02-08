
ENV["RACK_ENV"] = "test"
if ENV["COVERAGE"]
  require File.join(File.dirname(File.expand_path(__FILE__)), "minitest_rack_coverage")
  SimpleCov.minitest_rack_coverage
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubygems"
require "minitest/rack"
require "minitest/autorun"
require "minitest/assert_errors"

