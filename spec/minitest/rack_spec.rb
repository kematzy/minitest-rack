# frozen_string_literal: true

require_relative '../spec_helper'

describe 'Minitest::Rack' do
  it 'should have a version number' do
    _(Minitest::Rack::VERSION).wont_be_nil
    _(Minitest::Rack::VERSION).must_match(/^\d+\.\d+\.\d+$/)
  end
end

describe Minitest::Assertions do
  include Rack::Test::Methods

  describe '#assert_body(:res)' do
    let(:app) { ->(_env) { [200, {}, ['Hello World']] } }
    let(:response_body) { 'Hello World' }

    it 'passes when response body matches expected' do
      get '/'

      assert_body('Hello World')
    end

    it 'fails when response body does not match expected' do
      get '/'

      _ { assert_body('Wrong Body') }.must_raise Minitest::Assertion
    end
  end
end
