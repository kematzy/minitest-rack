# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

if ENV['COVERAGE']
  require File.join(File.dirname(File.expand_path(__FILE__)), 'minitest_rack_coverage')
  SimpleCov.minitest_rack_coverage
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'rubygems'
require 'rack/test'
require 'minitest/rack'
require 'minitest/autorun'
require 'minitest/hooks/default'
# require 'minitest/assert_errors'
require 'minitest/rg'

# used by rack/json tests
require 'sqlite3'
require 'sequel'

DB = Sequel.sqlite # :memory

DB.create_table(:users) do
  primary_key :id
  column :name, :text
  column :email, :text
end

class User < Sequel::Model
  plugin :json_serializer
end

# rubocop:disable Style/ClassAndModuleChildren
class Minitest::HooksSpec
  around(:all) do |&block|
    DB.transaction(rollback: :always) { super(&block) }
  end

  around do |&block|
    DB.transaction(rollback: :always, savepoint: true, auto_savepoint: true) { super(&block) }
  end

  if defined?(Capybara)
    after do
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren

# Add custom assertions
module Minitest
  module Assertions
    # Asserts the presence of a key in a nested data structure
    #
    # @param object [Hash, Object] The object to search through for the key path
    # @param key_path [String] A dot-separated path of keys to follow (e.g. "user.name.first")
    # @param msg [String, nil] Optional custom error message if assertion fails
    #
    # @return [true] If the key path exists
    #
    # @raise [Minitest::Assertion] If the key path is not found
    #
    # @example
    #   assert_has_key({"user" => {"name" => "John"}}, "user.name") # passes
    #   assert_has_key({"user" => {}}, "user.name") # fails
    #
    def assert_has_key(object, key_path, msg = nil)
      keys = key_path.to_s.split('.')
      current = object

      keys.each_with_index do |key, index|
        key = key.to_sym if current.is_a?(Hash) && current.key?(key.to_sym)

        unless current.respond_to?(:key?) && current.key?(key)
          path_tried = keys[0..index].join('.')
          full_path = key_path.to_s

          error_message = msg || build_key_error_message(
            object: object,
            path_tried: path_tried,
            full_path: full_path,
            current_value: current
          )

          raise Minitest::Assertion, error_message
        end

        current = current[key]
      end

      true
    end

    private

    # Builds a detailed error message for key path assertions
    #
    # @param object [Object] The complete object being checked
    # @param path_tried [String] The portion of the key path that was valid
    # @param full_path [String] The complete key path that was being searched for
    # @param current_value [Object] The value where the key path search failed
    #
    # @return [String] A multi-line error message explaining what went wrong
    #
    def build_key_error_message(object:, path_tried:, full_path:, current_value:)
      message = ["Expected to find key path '#{full_path}'"]
      message << "Found valid path until '#{path_tried}'"
      message << "Full object: #{object.inspect}"
      message << "Stopped at value: #{current_value.inspect}"

      if current_value.respond_to?(:key?)
        message << "Available keys at this level: #{current_value.keys.inspect}"
      end

      message.join("\n")
    end
  end

  module Expectations
    infect_an_assertion :assert_has_key, :must_have_key, :reverse
    infect_an_assertion :refute_has_key, :wont_have_key, :reverse
  end
end
