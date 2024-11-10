# frozen_string_literal: false

require_relative '../../spec_helper'

# rubocop:disable Metrics/BlockLength
describe Minitest::Assertions do
  include Rack::Test::Methods

  describe '#assert_header(:header, :contents)' do
    let(:html_body) { '<h1>Hello World</h1>' }
    let(:app) { ->(_env) { [200, { 'Content-Type' => 'text/html' }, [html_body]] } }

    it 'passes when header matches expected contents' do
      get '/'

      assert_header('Content-Type', 'text/html')
      assert_body(html_body)
    end

    it 'fails when header does not match expected contents' do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header('Content-Type', 'application/json')
      end

      msg = %r{Expected response header 'Content-Type' to be 'application/json'}

      assert_match(msg, err.message)
    end

    it 'fails when header does not exist' do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header('X-Missing-Header', 'value')
      end

      msg = /Expected response header 'X-Missing-Header' to be 'value'/

      assert_match(msg, err.message)
    end
  end

  describe '#assert_header_accept(:type)' do
    let(:app) { ->(_env) { [200, { 'Accept' => 'text/plain' }, []] } }

    it 'passes when Accept header matches expected type' do
      get '/'

      _(assert_header_accept('text/plain')).must_equal true
    end

    it 'fails when Accept header does not match expected type' do
      get '/'

      err = _(-> { assert_header_accept('application/json') }).must_raise(Minitest::Assertion)

      _(err.message).must_match(%r{Expected response header 'Accept' to be 'application/json'})
    end
  end

  describe '#assert_header_application_type(:type)' do
    let(:app) { ->(_env) { [200, { 'Content-Type' => 'application/pdf' }, []] } }

    it "passes when Content-Type 'application/:type' header matches expected type" do
      get '/'

      _(assert_header_application_type('pdf')).must_equal true
    end

    it "fails when Content-Type 'application/:type' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_application_type('xml')
      end

      msg = "Expected response header 'Content-Type' to be 'application/xml', "
      msg << "but was 'application/pdf'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_image_type(:type)' do
    let(:app) { ->(_env) { [200, { 'Content-Type' => 'image/jpg' }, []] } }

    it "passes when Content-Type ':type' header matches expected type" do
      get '/'

      _(assert_header_image_type('jpg')).must_equal true
    end

    it "fails when Content-Type ':type' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_image_type('png')
      end

      msg = "Expected response header 'Content-Type' to be 'image/png', "
      msg << "but was 'image/jpg'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_text_type(:type)' do
    let(:app) { ->(_env) { [200, { 'Content-Type' => 'text/plain' }, []] } }

    it "passes when Content-Type ':type' header matches expected type" do
      get '/'

      _(assert_header_text_type('plain')).must_equal true
    end

    it "fails when Content-Type ':type' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_text_type('html')
      end

      msg = "Expected response header 'Content-Type' to be 'text/html', but was 'text/plain'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_content_encoding(:encoding_str)' do
    let(:app) { ->(_env) { [200, { 'Content-Encoding' => 'gzip' }, []] } }

    it "passes when Content-Encoding ':encoding' header matches expected type" do
      get '/'

      _(assert_header_content_encoding('gzip')).must_equal true
    end

    it "fails when Content-Encoding ':encoding' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_content_encoding('xml')
      end

      msg = "Expected response header 'Content-Encoding' to be 'xml', "
      msg << "but was 'gzip'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_encoding(:encoding_str) (alias of #assert_header_content_encoding)' do
    let(:app) { ->(_env) { [200, { 'Content-Encoding' => 'gzip' }, []] } }

    it "passes when Content-Encoding ':encoding' header matches expected type" do
      get '/'

      _(assert_header_encoding('gzip')).must_equal true
    end

    it "fails when Content-Encoding ':encoding' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_encoding('xml')
      end

      msg = "Expected response header 'Content-Encoding' to be 'xml', "
      msg << "but was 'gzip'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_content_language(:lang)' do
    let(:app) { ->(_env) { [200, { 'Content-Language' => 'en' }, []] } }

    it "passes when Content-Language ':lang' header matches expected type" do
      get '/'

      _(assert_header_content_language('en')).must_equal true
    end

    it "fails when Content-Language ':lang' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_content_language('es')
      end

      msg = "Expected response header 'Content-Language' to be 'es', "
      msg << "but was 'en'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_language(:lang) (alias of #assert_header_content_language)' do
    let(:app) { ->(_env) { [200, { 'Content-Language' => 'en' }, []] } }

    it "passes when Content-Language ':lang' header matches expected type" do
      get '/'

      _(assert_header_language('en')).must_equal true
    end

    it "fails when Content-Language ':lang' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_language('es')
      end

      msg = "Expected response header 'Content-Language' to be 'es', but was 'en'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_content_length(:length)' do
    let(:app) { ->(_env) { [200, { 'Content-Length' => 5 }, ['Hello']] } }

    it "passes when Content-Length ':length' header matches expected type" do
      get '/'

      _(assert_header_content_length(5)).must_equal true
      _(assert_header_content_length('5')).must_equal true
    end

    it "fails when Content-Length ':length' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_content_length(10)
      end

      msg = "Expected response header 'Content-Length' to be '10', "
      msg << "but was '5'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_content_location(:url)' do
    let(:app) { ->(_env) { [200, { 'Content-Location' => '/index.htm' }, []] } }

    it "passes when Content-Location ':url' header matches expected type" do
      get '/'

      _(assert_header_content_location('/index.htm')).must_equal true
    end

    it "fails when Content-Location ':url' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_content_location('/test.php')
      end

      msg = "Expected response header 'Content-Location' to be '/test.php', "
      msg << "but was '/index.htm'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_content_type(:type)' do
    let(:app) { ->(_env) { [200, { 'Content-Type' => 'text/html; charset=utf-8' }, []] } }

    it "passes when Content-Type ':type' header matches expected type" do
      get '/'

      _(assert_header_content_type('text/html; charset=utf-8')).must_equal true
    end

    it "fails when Content-Type ':type' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_content_type('application/php')
      end

      msg = "Expected response header 'Content-Type' to be 'application/php', "
      msg << "but was 'text/html; charset=utf-8'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_etag(:tag)' do
    let(:app) { ->(_env) { [200, { 'ETag' => '"737060cd8c284d8af7ad3082f209582d"' }, []] } }

    it "passes when ETag ':tag' header matches expected type" do
      get '/'

      _(assert_header_etag('"737060cd8c284d8af7ad3082f209582d"')).must_equal true
    end

    it "fails when ETag ':tag' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_etag('"737060cd8c284dee3f7ad3082f209582d"')
      end

      msg = "Expected response header 'ETag' to be '\"737060cd8c284dee3f7ad3082f209582d\"', "
      msg << "but was '\"737060cd8c284d8af7ad3082f209582d\"'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_expires(:timestamp)' do
    let(:ts) { Time.parse('Thu, 01 Dec 1994 16:00:00 GMT') }
    let(:now) { Time.now }
    let(:app) { ->(_env) { [200, { 'Expires' => ts }, []] } }

    it "passes when Expires ':timestamp' header matches expected type" do
      get '/'

      _(assert_header_expires(ts)).must_equal true
    end

    it "fails when Expires ':timestamp' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_expires(now)
      end

      msg = "Expected response header 'Expires' to be '#{now}', but was '#{ts}'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_last_modified(:timestamp)' do
    let(:ts) { Time.parse('Thu, 01 Dec 1994 16:00:00 GMT') }
    let(:now) { Time.now }
    let(:app) { ->(_env) { [200, { 'Last-Modified' => ts }, []] } }

    it "passes when Last-Modified ':timestamp' header matches expected type" do
      get '/'

      _(assert_header_last_modified(ts)).must_equal true
    end

    it "fails when Last-Modified ':timestamp' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_last_modified(now)
      end

      msg = "Expected response header 'Last-Modified' to be '#{now}', but was '#{ts}'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_server(:server_str)' do
    let(:app) { ->(_env) { [200, { 'Server' => 'Apache/2.4.1 (Unix)' }, []] } }

    it "passes when Server ':server_str' header matches expected type" do
      get '/'

      _(assert_header_server('Apache/2.4.1 (Unix)')).must_equal true
    end

    it "fails when Server ':server_str' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_server('Caddy')
      end

      msg = "Expected response header 'Server' to be 'Caddy', but was 'Apache/2.4.1 (Unix)'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_www_authenticate(:auth_str)' do
    let(:app) { ->(_env) { [200, { 'WWW-Authenticate' => 'Basic' }, []] } }

    it "passes when WWW-Authenticate ':auth_str' header matches expected type" do
      get '/'

      _(assert_header_www_authenticate('Basic')).must_equal true
    end

    it "fails when WWW-Authenticate ':auth_str' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_www_authenticate('Bearer realm="example"')
      end

      msg = "Expected response header 'WWW-Authenticate' to be 'Bearer realm=\"example\"', "
      msg << "but was 'Basic'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_attachment(:filename)' do
    let(:app) do
      lambda { |_env|
        [200, { 'Content-Disposition' => 'attachment; filename="document.pdf"' }, []]
      }
    end

    it "passes when Content-Disposition ':filename' header matches expected type" do
      get '/'

      _(assert_header_attachment('document.pdf')).must_equal true
    end

    it "fails when Content-Disposition ':filename' header does not match expected type" do
      get '/'

      err = assert_raises(Minitest::Assertion) do
        assert_header_attachment('incorrect.pdf')
      end

      msg = "Expected response header 'Content-Disposition' to be "
      msg << "'attachment; filename=\"incorrect.pdf\"', "
      msg << "but was 'attachment; filename=\"document.pdf\"'"

      _(err.message).must_match(msg)
    end
  end

  describe '#assert_header_type_is_json' do
    describe "when Content-Type is 'application/json'" do
      let(:app) { ->(_env) { [200, { 'Content-Type' => 'application/json' }, []] } }

      it 'returns true' do
        get '/'

        _(assert_header_type_is_json).must_equal true
      end
    end

    describe "when Content-Type is NOT 'application/json'" do
      let(:app) { ->(_env) { [200, { 'Content-Type' => 'application/xml' }, []] } }

      it 'fails when Content-Type is not JSON' do
        get '/'

        err = assert_raises(Minitest::Assertion) do
          assert_header_type_is_json
        end

        msg = "Expected response header 'Content-Type' to be 'application/json', "
        msg << "but was 'application/xml'"

        _(err.message).must_match(msg)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
