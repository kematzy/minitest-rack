require "rack/test"
require "json"

module Minitest
  module Rack
    module JSON
      
      module Assertions

        # 
        # 
        # 
        def json_data
          ::JSON.parse(last_response.body)
        end
      
        # 
        # 
        # 
        def assert_json_data(res)
          data = json_data
          assert_equal(res.values, data, "Expected response JSON data to be '#{res.values}', but was '#{data.inspect}'")
        end

        # 
        # 
        # 
        def assert_json_success(bool = true)
          data = json_data
          assert_equal(bool, data["success"], "Expected response JSON data to include '\"success\": #{bool}', but was '#{data.inspect}'")
        end

        # 
        # 
        # 
        def assert_json_error(errno = "404")
          data = json_data
          assert_equal(errno.to_s, data["error"], "Expected response JSON data to include '\"error\": #{errno.to_s}', but was '#{data.inspect}'")
        end

        # 
        # 
        # 
        def assert_json_message(msg)
          data = json_data
          assert_equal(msg, data["message"], "Expected response JSON data to include '\"message\": #{msg}', but was '#{data.inspect}'")
        end

        # 
        # 
        # 
        def assert_json_model(key, model)
          data = json_data
          assert_equal(model.to_json, data[key.to_s], "Expected response JSON data to include '\"#{key}\": #{model.to_json}', but was '#{data.inspect}'")
        end

        # 
        # 
        # 
        def assert_json_key(key)
          data = json_data
          refute_empty(data[key], "Expected response JSON data to include key '\"#{key}\"', but JSON is '#{data.inspect}'")
        end

        # 
        # 
        # 
        def assert_json_model_key(model, key)
          data = json_data
          refute_empty(data[model][key], "Expected response JSON data to include key '[#{model}][#{key}]', but JSON is '#{data.inspect}'")
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


          def json_request(verb, path, params = {}, headers = {})
            send(verb, path, params.to_json, headers.merge({ "Content-Type" => "application/json" }))
          end

      end


      module Expectations
        
      end

    end
  end
end

# include the assertions into Minitest
class Minitest::Test
  include Minitest::Rack::JSON::Assertions
  # include Minitest::Rack::JSON::Expectations
end
