# frozen_string_literal: false

require_relative '../../spec_helper'

# rubocop:disable Metrics/BlockLength
describe Minitest::Assertions do
  include Rack::Test::Methods

  describe '#json_data()' do
    describe 'with valid JSON' do
      let(:body) { { key: 'value' } }
      let(:app) { ->(_env) { [200, { 'Content-Type' => 'application/json' }, [body.to_json]] } }

      it 'parses JSON response body' do
        get '/'

        result = json_data
        _(result).must_equal({ 'key' => 'value' })
      end
    end
    # /with valid JSON

    describe 'with invalid JSON' do
      let(:body) { '{"invalid: "value"}' }
      let(:app) { ->(_env) { [200, { 'Content-Type' => 'application/json' }, [body]] } }

      it 'raises error for invalid JSON' do
        get '/'

        _(proc { json_data }).must_raise(JSON::ParserError)
      end
    end
    # /with invalid JSON
  end
  # /#json_data()

  describe '#assert_json_data(:res)' do
    describe 'with valid data' do
      let(:body) { { id: 1, name: 'test' } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when response matches expected data' do
        get '/'

        assert_json_data({ 'id' => 1, 'name' => 'test' })
      end

      it 'fails when response does not match expected data' do
        get '/'

        assert_raises(Minitest::Assertion) do
          assert_json_data({ 'id' => 2, 'name' => 'wrong' })
        end
      end
    end
    # /with valid data

    describe 'with empty response data' do
      let(:body) { {} }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'handles empty response data' do
        get '/'

        assert_json_data({})
      end
    end
    # /with empty response data
    #
    describe 'with nested data structures' do
      let(:body) { { nested: { id: 1 } } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'handles empty response data' do
        get '/'

        assert_json_data({ 'nested' => { 'id' => 1 } })
      end
    end
    # /with empty response data
  end
  # /#assert_json_data(:res)

  describe '#assert_json_success(:bool)' do
    describe 'with valid data and response contains :success => true' do
      let(:body) { { id: 1, success: true } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed nothing (default)' do
        get '/'

        _(assert_json_success).must_equal true
      end

      it 'passes when passed [bool: true]' do
        get '/'

        _(assert_json_success(bool: true)).must_equal true
      end

      it 'raises an ArgumentError when passed :true' do
        get '/'

        assert_raises(ArgumentError) do
          assert_json_success(true)
        end
      end

      it 'raises an error when passed [bool: false]' do
        get '/'

        err = _(-> { assert_json_success(bool: false) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"success": false\', '
        msg << 'but was \'{"id"=>1, "success"=>true}\''

        _(err.message).must_match(msg)
      end
    end
    # /with valid data

    describe 'with empty response data' do
      let(:body) { {} }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'handles empty response data' do
        get '/'

        err = _(-> { assert_json_success(bool: true) }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include '\"success\": true', but was '{}'"

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data
    #
    describe 'with nested data structures' do
      let(:body) { { nested: { id: 1 }, success: true } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed nothing (default)' do
        get '/'

        _(assert_json_success).must_equal true
      end

      it 'passes when passed [bool: true]' do
        get '/'

        _(assert_json_success(bool: true)).must_equal true
      end

      it 'raises an ArgumentError when passed :true' do
        get '/'

        assert_raises(ArgumentError) do
          assert_json_success(true)
        end
      end

      it 'raises an error when passed [bool: false]' do
        get '/'

        err = _(-> { assert_json_success(bool: false) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"success": false\', '
        msg << 'but was \'{"nested"=>{"id"=>1}, "success"=>true}\''

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data
  end
  # /#assert_json_success(:bool)

  describe '#assert_json_error(:errno)' do
    describe 'with valid data and response contains :error => 404' do
      let(:body) { { id: 1, error: 404 } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed nothing (default)' do
        get '/'

        _(assert_json_error).must_equal true
      end

      it 'passes when passed 404 as integer' do
        get '/'

        _(assert_json_error(404)).must_equal true
      end

      it 'passes when passed 404 as string' do
        get '/'

        _(assert_json_error('404')).must_equal true
      end

      it 'raises an error when passed 401 (invalid error code)' do
        get '/'

        err = _(-> { assert_json_error(401) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"error": 401\', '
        msg << 'but was \'{"id"=>1, "error"=>404}\''

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed []' do
        get '/'

        err = _(-> { assert_json_error([]) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"error": []\', '
        msg << 'but was \'{"id"=>1, "error"=>404}\''

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed :nil' do
        get '/'

        err = _(-> { assert_json_error(nil) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"error": \', '
        msg << 'but was \'{"id"=>1, "error"=>404}\''

        _(err.message).must_match(msg)
      end
    end
    # /with valid data

    describe 'with empty response data' do
      let(:body) { {} }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'handles empty response data' do
        get '/'

        err = _(-> { assert_json_error }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include '\"error\": 404', but was '{}'"

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data

    describe 'with nested data structures' do
      let(:body) { { nested: { id: 1 }, error: 404 } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed nothing (default)' do
        get '/'

        _(assert_json_error).must_equal true
      end

      it 'passes when passed 404' do
        get '/'

        _(assert_json_error(404)).must_equal true
      end

      it 'raises an error when passed 401' do
        get '/'

        err = _(-> { assert_json_error(401) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"error": 401\', '
        msg << 'but was \'{"nested"=>{"id"=>1}, "error"=>404}\''

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed true' do
        get '/'

        err = _(-> { assert_json_error(true) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"error": true\', '
        msg << 'but was \'{"nested"=>{"id"=>1}, "error"=>404}\''

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data
  end
  # /#assert_json_error(:bool)

  describe '#assert_json_message(:message)' do
    describe 'with valid data and response contains :message => "hi"' do
      let(:body) { { id: 1, message: 'hi' } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed the correct message' do
        get '/'

        _(assert_json_message('hi')).must_equal true
      end

      it 'raises an ArgumentError when passed nothing' do
        get '/'

        assert_raises(ArgumentError) do
          assert_json_message
        end
      end

      it 'raises an error when passed invalid message' do
        get '/'

        err = _(-> { assert_json_message('invalid') }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"message": invalid\', '
        msg << 'but was \'{"id"=>1, "message"=>"hi"}\''

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed []' do
        get '/'

        err = _(-> { assert_json_message([]) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"message": []\', '
        msg << 'but was \'{"id"=>1, "message"=>"hi"}\''

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed :nil' do
        get '/'

        err = _(-> { assert_json_message(nil) }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"message": \', '
        msg << 'but was \'{"id"=>1, "message"=>"hi"}\''

        _(err.message).must_match(msg)
      end
    end
    # /with valid data

    describe 'with empty response data' do
      let(:body) { {} }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'handles empty response data' do
        get '/'

        err = _(-> { assert_json_message('test') }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include '\"message\": test', but was '{}'"

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data

    describe 'with nested data structures' do
      let(:body) { { nested: { id: 1 }, message: 'hi' } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed valid message' do
        get '/'

        _(assert_json_message('hi')).must_equal true
      end

      it 'raises an error when passed invalid test message' do
        get '/'

        err = _(-> { assert_json_message('test') }).must_raise(Minitest::Assertion)

        msg = 'Expected response JSON data to include \'"message": test\', '
        msg << 'but was \'{"nested"=>{"id"=>1}, "message"=>"hi"}\''

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data
  end
  # /#assert_json_message(:message)

  describe '#assert_json_model(:key, :model)' do
    describe 'with valid data and response contains :user' do
      let(:attrs) { { name: 'Joe Blogs', email: 'joe@email.com' } }
      let(:user) { User.new(attrs) }
      let(:app) { ->(_env) { [200, {}, [{ user: attrs, success: true }.to_json]] } }

      it 'passes when passed the correct params' do
        get '/'

        _(assert_json_model('user', user)).must_equal true
      end

      it 'raises an ArgumentError when missing params' do
        get '/'

        assert_raises(ArgumentError) do
          assert_json_model()
        end

        assert_raises(ArgumentError) do
          assert_json_model('user')
        end
      end

      it 'raises an error when passed invalid model {}' do
        get '/'

        err = _(-> { assert_json_model('user', {}) }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include 'user: {}', "
        msg << "but was '#{user.values.to_json}'"

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed incorrect key: :wrong' do
        get '/'

        err = _(-> { assert_json_model('wrong', user) }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include key: 'wrong', but JSON is: "
        msg << "'{\"user\"=>{\"name\"=>\"Joe Blogs\", \"email\"=>\"joe@email.com\"}, \"success\"=>true}'"

        _(err.message).must_match(msg)
      end
    end
    # /with valid data

    describe 'with empty response data' do
      let(:attrs) { { name: 'Joe Blogs', email: 'joe@email.com' } }
      let(:user) { User.new(attrs) }
      let(:app) { ->(_env) { [200, {}, [{}.to_json]] } }

      it 'handles empty response data' do
        get '/'

        err = _(-> { assert_json_model('user', user) }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include key: 'user', but JSON is: '{}'"

        _(err.message).must_match(msg)
      end
    end
    # /with empty response data

    describe 'with nested data structures' do
      let(:attrs) { { name: 'Joe Blogs', email: 'joe@email.com' } }
      let(:user) { User.new(attrs) }
      let(:body) { { nested: { test: true }, success: true, user: attrs } }
      let(:app) { ->(_env) { [200, {}, [body.to_json]] } }

      it 'passes when passed valid message' do
        get '/'

        _(assert_json_model('user', user)).must_equal true
      end
    end
    # /with empty response data
  end
  # /#assert_json_model(:key, :model)

  describe '#assert_json_key(:key)' do
    describe 'with valid data and response contains :user' do
      let(:attrs) { { name: 'Joe Blogs', email: 'joe@email.com' } }
      let(:app) { ->(_env) { [200, {}, [{ user: attrs, success: true }.to_json]] } }

      it 'passes when passed the correct params' do
        get '/'

        _(assert_json_key('user')).must_equal true
      end

      it 'raises an error when passed incorrect key: :wrong' do
        get '/'

        err = _(-> { assert_json_key('wrong') }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include key: 'wrong', "
        msg << "but JSON is '{\"user\"=>{\"name\"=>\"Joe Blogs\", \"email\"=>\"joe@email.com\"}, \"success\"=>true}'"

        _(err.message).must_match(msg)
      end
    end
  end
  # /#assert_json_key(:key)

  describe '#assert_json_model_key(:model, :key)' do
    describe 'with valid data and response contains :user' do
      let(:attrs) { { name: 'Joe Blogs', email: 'joe@email.com' } }
      let(:user) { User.new(attrs) }
      let(:app) { ->(_env) { [200, {}, [{ user: attrs, success: true }.to_json]] } }

      it 'passes when passed the correct params' do
        get '/'

        _(assert_json_model_key('user', 'email')).must_equal true
      end

      it 'raises an ArgumentError when missing params' do
        get '/'

        assert_raises(ArgumentError) do
          assert_json_model_key()
        end

        assert_raises(ArgumentError) do
          assert_json_model_key('user')
        end
      end

      it 'raises an error when passed invalid :model' do
        get '/'

        err = _(-> { assert_json_model_key('wrong', 'email') }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include model: 'wrong', but it did not"

        _(err.message).must_match(msg)
      end

      it 'raises an error when passed invalid :key' do
        get '/'

        err = _(-> { assert_json_model_key('user', 'wrong') }).must_raise(Minitest::Assertion)

        msg = "Expected response JSON data to include model.key: 'user.wrong', but it did not"

        _(err.message).must_match(msg)
      end

      # it 'raises an error when passed incorrect key: :wrong' do
      #   get '/'

      #   err = _(-> { assert_json_model_key('user', 'wrong') }).must_raise(Minitest::Assertion)

      #   msg = "Expected response JSON data to include the key: 'wrong', but it did not"

      #   _(err.message).must_match(msg)
      # end
    end
    # /with valid data
  end
  # /#assert_json_model_key(:model, :key)

  describe '#get_json(:path, :params, :headers)' do
    let(:app) { ->(_env) {
      [200, { 'Content-Type' => 'application/json' }, [{success: true}.to_json]] }
    }

    it 'makes a GET request with JSON data' do
      get_json('/', { id: 1 })

      _(last_request.get?).must_equal true
      _(last_request.url).must_equal "http://example.org/?%7B%22id%22%3A1%7D"
      _(last_response.content_type).must_equal 'application/json'
      _(last_response.body).must_equal("{\"success\":true}")
    end
  end
  # /#get_json(:path, :params, :headers)

  describe '#post_json(:path, :params, :headers)' do
    let(:app) {
      ->(_env) {
        [200, { 'Content-Type' => 'application/json' }, [{success: true}.to_json]]
      }
    }

    it 'makes a POST request with JSON data' do
      post_json('/test', { name: 'test' })

      _(last_request.post?).must_equal true
      _(last_request.body.read).must_equal({ name: 'test' }.to_json)
      _(last_response.content_type).must_equal 'application/json'
      _(last_response.body).must_equal("{\"success\":true}")
    end
  end
  # /#post_json(:path, :params, :headers)

  describe '#put_json(:path, :params, :headers)' do
    let(:app) {
      ->(_env) {
        [200, { 'Content-Type' => 'application/json' }, [{success: true}.to_json]]
      }
    }

    it 'makes a PUT request with JSON data' do
      put_json('/test', { id: 1, name: 'test' })

      _(last_request.put?).must_equal true
      _(last_request.body.read).must_equal({ id: 1, name: 'test' }.to_json)
      _(last_response.content_type).must_equal 'application/json'
    end
  end
  # /#put_json(:path, :params, :headers)

  describe '#delete_json(:path, :params, :headers)' do
    let(:app) {
      ->(_env) {
        [200, { 'Content-Type' => 'application/json' }, [{success: true}.to_json]]
      }
    }

    it 'makes a DELETE request with JSON data' do
      delete_json('/test', { id: 1 })

      _(last_request.delete?).must_equal true
      _(last_request.body.read).must_equal({id: 1}.to_json)
      _(last_response.content_type).must_equal 'application/json'
    end
  end
  # /#delete_json(:path, :params, :headers)

  describe '#json_request(:verb, :path, :params, :headers)' do
    let(:headers) { {'Content-Type' => 'application/json'} }
    let(:app) { ->(_env) {
      [200, { 'Content-Type' => 'application/json' }, [{success: true}.to_json]] }
    }

    it 'makes a GET request with JSON data' do
      json_request(:get, '/', { id: 1 })

      _(last_request.get?).must_equal true
      _(last_request.url).must_equal "http://example.org/?%7B%22id%22%3A1%7D"
      _(last_response.content_type).must_equal 'application/json'
      _(last_response.body).must_equal("{\"success\":true}")
    end

    it 'makes a POST request with JSON data' do
      json_request(:post, '/test', { name: 'test' })

      _(last_request.post?).must_equal true
      _(last_request.body.read).must_equal({ name: 'test' }.to_json)
      _(last_response.content_type).must_equal 'application/json'
      _(last_response.body).must_equal("{\"success\":true}")
    end

    it 'makes a PUT request with JSON data' do
      json_request(:put, '/test', { id: 1, name: 'test' })

      _(last_request.put?).must_equal true
      _(last_request.body.read).must_equal({ id: 1, name: 'test' }.to_json)
      _(last_response.content_type).must_equal 'application/json'
    end

    it 'makes a DELETE request with JSON data' do
      json_request(:delete, '/test', {id: 1})

      _(last_request.delete?).must_equal true
      _(last_request.body.read).must_equal({id: 1}.to_json)
      _(last_response.content_type).must_equal 'application/json'
    end

    it 'merges custom headers' do
      custom_headers = {'X-Custom' => 'value'}
      json_request(:get, '/test', {}, custom_headers)

      _(last_request.get_header('X-Custom')).must_equal 'value'
      _(last_response.content_type).must_equal 'application/json'
    end
  end
end
# rubocop:enable Metrics/BlockLength
