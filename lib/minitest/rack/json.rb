# frozen_string_literal: false

require 'rack/test'
require 'json'
require 'minitest/assertions'
require 'minitest/spec'

# reopening to add validations functionality
module Minitest
  # add support for Assert syntax
  module Assertions
    # Parse the response body of the last response as JSON using the native Ruby
    # JSON parser. This method helps in quickly grabbing the JSON data from the
    # response to verify in assertions.
    #
    # @return [Hash] parsed JSON data from the response body
    #
    def json_data
      ::JSON.parse(last_response.body)
    end

    # Asserts against the presence of specific key/value pairs in the response JSON data. When
    # testing endpoint responses for JSON data conformity, it ensures the response matches the
    # expected data exactly. Takes a hash of expected data and validates it against the parsed
    # JSON response.
    #
    # @param res [Hash] hash containing the expected key/value pairs that should be
    # present in the JSON response data
    #
    # @return [Boolean] true when response data matches expected data
    #
    # @example
    #   # Response body contains: {"id": 1, "name": "test"}
    #   assert_json_data({id: 1, name: "test"}) # => true
    #
    def assert_json_data(res)
      data = json_data

      msg = "Expected response JSON data to be '#{res}', but was '#{data}'"

      assert_equal(res, data, msg)
    end

    # Verify if the response JSON data contains a success attribute with specified truth value.
    # This method specifically checks for the presence of a "success" key and validates its
    # value against the expected boolean. By default, it expects true unless otherwise specified.
    #
    # @param bool [Boolean] the expected value of success attribute (defaults to true)
    #
    # @return [Boolean] true when the success value matches the expected boolean
    #
    def assert_json_success(bool: true)
      data = json_data

      msg = "Expected response JSON data to include '\"success\": #{bool}', "
      msg << "but was '#{data.inspect}'"

      assert_equal(bool, data['success'], msg)
    end

    # Asserts that the response JSON data contains an 'error' attribute with the specified
    # error code and validates that its value matches the expected error code string.
    # Default error code is "404" if none specified.
    #
    # @param errno [String] the expected error code value (defaults to "404")
    #
    # @return [Boolean] true when the error value matches the expected error code
    #
    def assert_json_error(errno = '404')
      data = json_data

      msg = "Expected response JSON data to include '\"error\": #{errno}', "
      msg << "but was '#{data.inspect}'"

      assert_equal(errno.to_s, data['error'].to_s, msg)
    end

    # Verifies that the response JSON data contains a message attribute with the
    # specified message string.
    # This method checks for the presence of a "message" key and validates that its
    # value matches the expected message text.
    #
    # @param msg [String] the expected message value to check for in the response
    #
    # @return [Boolean] true when the message value matches the expected message string
    #
    def assert_json_message(message)
      data = json_data

      msg = "Expected response JSON data to include '\"message\": #{message}', "
      msg << "but was '#{data.inspect}'"

      assert_equal(message, data['message'], msg)
    end

    # Verifies that the response JSON data contains a specific model attribute with
    # the expected model data.
    # This method checks if the response contains a key matching the provided model name and
    # validates that its JSON representation matches the expected model object.
    #
    # @param key [String, Symbol] the model key to check for in the response
    # @param model [Object] the model object whose JSON representation matches the response data
    #
    # @return [Boolean] true when the model JSON matches the response data for the given key
    #
    # @example
    #   # Response body contains: {"user": {"id": 1, "name": "Bob"}}
    #   user = User.new(id: 1, name: "Bob")
    #   assert_json_model('user', user) # => true
    #
    def assert_json_model(key, model)
      data = json_data
      key = key.to_s

      msg = "Expected response JSON data to include "

      # handle wrong key value being passed
      if data.key?(key)
        msg << "'#{key}: #{model.to_json}', but was '#{data[key].to_json}'"
        assert_equal(model.values.to_json, data[key].to_json, msg)
      else
        msg << "key: '#{key}', but JSON is: '#{data}'"
        assert_has_key data, "#{key}", msg
      end
    end

    # Verifies that the response JSON data contains the specified key with a non-empty value.
    # This method checks for the presence of a given key in the response and validates that
    # its value is not empty, ensuring the expected data field exists and has content.
    #
    # @param key [String, Symbol] the key to check for in the response
    #
    # @return [Boolean] true when the key exists and has a non-empty value
    #
    def assert_json_key(key)
      data = json_data
      key = key.to_s

      msg = "Expected response JSON data to include "

      # handle the model being present
      if data.key?(key)
        msg << "key: '#{key}', but JSON is '#{data}'"
        refute_empty(data[key], msg)
      else
        msg << "key: '#{key}', but JSON is '#{data}'"
        assert_has_key data, "#{key}", msg
      end
    end

    # Verifies that the response JSON data contains a nested key within a model attribute
    # and that the key's value is not empty.
    # This method checks if the response contains a model key and a nested key within it,
    # validating that the nested key's value exists and is not empty.
    #
    # @param model [String, Symbol] the model key to check for in the response
    # @param key [String, Symbol] the nested key to check within the model object
    #
    # @return [Boolean] true when the nested key exists and has a non-empty value
    #
    def assert_json_model_key(model, key)
      data = json_data
      model = model.to_s
      key = key.to_s

      msg = "Expected response JSON data to include "

      # handle the model being present
      if data.key?(model)
        if data[model].key?(key)
          msg = "life is great"
          refute_empty(data[model][key], msg)
        else
          msg << "model.key: '#{model}.#{key}', but it did not"
          assert_has_key data, "#{model}.#{key}", msg
        end
      else
        msg << "model: '#{model}', but it did not"
        assert_has_key data, "#{model}", msg
      end
    end

    # Shortcut for sending GET requests as JSON
    #
    #     get_json("/api/users")
    #
    def get_json(path, params = {}, headers = {})
      json_request(:get, path, params, headers)
    end

    # Shortcut for sending POST requests as JSON
    #
    #     post_json("/api/users", {name: "Joe"})
    #
    def post_json(path, params = {}, headers = {})
      json_request(:post, path, params, headers)
    end

    # Shortcut for sending PUT requests as JSON
    #
    #     put_json("/api/users/1234", {id: 1, name: "Joe"})
    #
    def put_json(path, params = {}, headers = {})
      json_request(:put, path, params, headers)
    end

    # Shortcut for sending DELETE requests as JSON
    #
    #     delete_json("/api/users/1234")
    #
    def delete_json(path, params = {}, headers = {})
      json_request(:delete, path, params, headers)
    end

    private

    # Makes an HTTP request with JSON data. This helper method is used by the HTTP verb shortcuts
    # (get_json, post_json, etc) to standardize JSON request handling. It converts the params
    # to JSON and sets the appropriate content type header.
    #
    # @param verb [Symbol] the HTTP verb to use (:get, :post, :put, :delete)
    # @param path [String] the URL path for the request
    # @param params [Hash] parameters to be converted to JSON and sent with request (default: {})
    # @param headers [Hash] HTTP headers to include with request (default: {})
    #
    # @return [Response] the response from the HTTP request
    #
    def json_request(verb, path, params = {}, headers = {})
      send(verb, path, params.to_json, headers.merge({ 'Content-Type' => 'application/json' }))
    end
  end
  # /module Assertions

  # add support for Spec syntax
  module Expectations
    infect_an_assertion :assert_json_data, :must_have_json_data, :reverse
    infect_an_assertion :assert_json_success, :must_have_json_success, :reverse
    infect_an_assertion :assert_json_error, :must_have_json_error, :reverse
    infect_an_assertion :assert_json_message, :must_have_json_message, :reverse
    infect_an_assertion :assert_json_key, :must_have_json_key, :reverse
    infect_an_assertion :assert_json_model, :must_have_json_model, :reverse
    infect_an_assertion :assert_json_model, :must_have_json_model_key, :reverse

    # def must_have_json_model(key, model)
    #   data = ::JSON.parse(last_response.body)
    #   expect(data[key.to_s]).must_equal(model.to_json)
    # end

    # def must_have_json_model_key(model, key)
    #   data = ::JSON.parse(last_response.body)
    #   expect(data[model][key]).wont_be_empty
    # end
  end
end
