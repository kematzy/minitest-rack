# frozen_string_literal: false

require_relative '../../spec_helper'

# rubocop:disable Metrics/BlockLength
describe Minitest::Assertions do
  include Rack::Test::Methods

  let(:body) { 'Hello World' }

  describe '#assert_status(:status)' do
    let(:app) { ->(_env) { [200, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'

      assert_status(200)
    end

    it 'fails when status does not match expected value' do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_status(404)
      end

      assert_match(/Expected response status to be '404', but was '200'/, err.message)
    end
  end
  # /#assert_status(:status)

  describe '#assert_ok() - 200' do
    let(:app) { ->(_env) { [200, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'

      assert_ok
    end
  end
  # /#assert_ok()

  describe '#assert_created() - 201' do
    let(:app) { ->(_env) { [201, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_created
    end
  end
  # /#assert_created()

  describe '#assert_accepted()' do
    let(:app) { ->(_env) { [202, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_accepted
    end
  end
  # /#assert_accepted()

  describe '#assert_no_content()' do
    let(:app) { ->(_env) { [204, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_no_content
    end
  end
  # /#assert_no_content()

  describe '#assert_reset_content()' do
    let(:app) { ->(_env) { [205, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_reset_content
    end
  end
  # /#assert_reset_content()

  describe '#assert_partial_content()' do
    let(:app) { ->(_env) { [206, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_partial_content
    end
  end
  # /#assert_partial_content()

  describe '#assert_multiple_choices()' do
    let(:app) { ->(_env) { [300, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_multiple_choices
    end
  end
  # /#assert_multiple_choices()

  describe '#assert_moved_permanently()' do
    let(:app) { ->(_env) { [301, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_moved_permanently
    end
  end
  # /#assert_moved_permanently()

  describe '#assert_found()' do
    let(:app) { ->(_env) { [302, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_found
    end
  end
  # /#assert_found()

  describe '#assert_not_modified()' do
    let(:app) { ->(_env) { [304, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_not_modified
    end
  end
  # /#assert_not_modified()

  describe '#assert_use_proxy()' do
    let(:app) { ->(_env) { [305, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_use_proxy
    end
  end
  # /#assert_use_proxy()

  describe '#assert_switch_proxy()' do
    let(:app) { ->(_env) { [306, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_switch_proxy
    end
  end
  # /#assert_switch_proxy()

  describe '#assert_temporary_redirect()' do
    let(:app) { ->(_env) { [307, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_temporary_redirect
    end
  end
  # /#assert_temporary_redirect()

  describe '#assert_permanent_redirect()' do
    let(:app) { ->(_env) { [308, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_permanent_redirect
    end
  end
  # /#assert_permanent_redirect()

  describe '#assert_bad_request()' do
    let(:app) { ->(_env) { [400, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_bad_request
    end
  end
  # /#assert_bad_request()

  describe '#assert_unauthorized()' do
    let(:app) { ->(_env) { [401, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_unauthorized
    end
  end
  # /#assert_unauthorized()

  describe '#assert_forbidden()' do
    let(:app) { ->(_env) { [403, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_forbidden
    end
  end
  # /#assert_forbidden()

  describe '#assert_not_found()' do
    let(:app) { ->(_env) { [404, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_not_found
    end
  end
  # /#assert_not_found()

  describe '#assert_method_not_allowed()' do
    let(:app) { ->(_env) { [405, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_method_not_allowed
    end
  end
  # /#assert_method_not_allowed()

  describe '#assert_not_acceptable()' do
    let(:app) { ->(_env) { [406, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_not_acceptable
    end
  end
  # /#assert_not_acceptable()

  describe '#assert_proxy_authentication_required()' do
    let(:app) { ->(_env) { [407, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_proxy_authentication_required
    end
  end
  # /#assert_proxy_authentication_required()

  describe '#assert_request_timeout()' do
    let(:app) { ->(_env) { [408, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_request_timeout
    end
  end
  # /#assert_request_timeout()

  describe '#assert_unsupported_media_type()' do
    let(:app) { ->(_env) { [415, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_unsupported_media_type
    end
  end
  # /#assert_unsupported_media_type()

  describe '#assert_unprocessable_entity()' do
    let(:app) { ->(_env) { [422, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_unprocessable_entity
    end
  end
  # /#assert_unprocessable_entity()

  describe '#assert_too_many_requests()' do
    let(:app) { ->(_env) { [429, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_too_many_requests
    end
  end
  # /#assert_too_many_requests()

  describe '#assert_internal_server_error()' do
    let(:app) { ->(_env) { [500, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_internal_server_error
    end
  end
  # /#assert_internal_server_error()

  describe '#assert_not_implemented()' do
    let(:app) { ->(_env) { [501, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_not_implemented
    end
  end
  # /#assert_not_implemented()

  describe '#assert_bad_gateway()' do
    let(:app) { ->(_env) { [502, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_bad_gateway
    end
  end
  # /#assert_bad_gateway()

  describe '#assert_service_unavailable()' do
    let(:app) { ->(_env) { [503, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_service_unavailable
    end
  end
  # /#assert_service_unavailable()

  describe '#assert_loop_detected()' do
    let(:app) { ->(_env) { [508, {}, [body]] } }

    it 'passes when status matches expected value' do
      get '/'
      assert_loop_detected
    end
  end
  # /#assert_loop_detected()
end
# rubocop:enable Metrics/BlockLength
