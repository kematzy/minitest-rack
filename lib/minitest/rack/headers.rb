# frozen_string_literal: true

require 'minitest/assertions'
require 'minitest/spec'

# reopening to add validations functionality
module Minitest
  # add support for Assert syntax
  module Assertions
    # Test if a specific response header has an expected value
    # Essentially, a shortcut for testing the `last_response.header` value
    #
    # @param [String] header The name of the HTTP header to check
    # @param [String] contents The expected value of the header
    #
    # @return [Boolean] True if header matches expected value
    #
    # Example:
    #    assert_header('Accept', 'text/plain')
    #
    def assert_header(header, contents)
      msg = "Expected response header '#{header}' to be '#{contents}', "
      msg << "but was '#{last_response.headers[header]}'"

      assert_equal(contents, last_response.headers[header], msg)
    end

    # Tests that a header contains the Accept content-type
    # Accept indicates which content-types the client can process
    #
    # @param [String] type The content-type to check for
    #
    # @return [Boolean] True if Accept header matches the specified type
    #
    # Example:
    #    assert_header_accept("text/plain")
    #
    def assert_header_accept(type)
      assert_header('Accept', type)
    end

    # Test for the `application/` type header via `Content-Type`
    # Valid application types include pdf, json, xml, etc.
    #
    # @param [String] type The application content-type suffix (e.g. "pdf", "json")
    #
    # @return [Boolean] True if Content-Type header matches "application/type"
    #
    # Example:
    #   assert_header_application_type('pdf')
    #   # Tests Content-Type equals 'application/pdf'
    #
    def assert_header_application_type(type)
      assert_header('Content-Type', "application/#{type}")
    end

    # Test if Content-Encoding header matches expected value
    # Content-Encoding specifies what encodings have been applied to the payload.
    # Common encoding types include gzip, compress, deflate, br
    #
    # @param [String] encoding_str The expected content encoding value
    #
    # @return [Boolean] True if Content-Encoding matches expected value
    #
    # Example:
    #   assert_header_content_encoding('gzip')
    #
    #   assert_header_encoding('gzip')
    #
    def assert_header_content_encoding(encoding_str)
      assert_header('Content-Encoding', encoding_str)
    end
    alias assert_header_encoding assert_header_content_encoding

    # Tests that the Content-Language header matches an expected value
    # Content-Language indicates the language of the content returned by the server
    #
    # @param [String] lang The expected language value
    #
    # @return [Boolean] True if Content-Language matches the expected value
    #
    # Example:
    #   assert_header_content_language('en')
    #   assert_header_content_language('fr')
    #
    def assert_header_content_language(lang)
      assert_header('Content-Language', lang)
    end
    alias assert_header_language assert_header_content_language

    # Tests that the Content-Length header matches the expected value
    # Content-Length specifies the size of the response body in bytes
    #
    # @param [String, Integer] length The expected content length value
    #
    # @return [Boolean] True if Content-Length matches the expected value
    #
    # Example:
    #   assert_header_content_length(348)
    #   assert_header_content_length("348")
    #
    def assert_header_content_length(length)
      assert_header('Content-Length', length.to_s)
    end

    # Test if Content-Location header matches expected value
    # Content-Location indicates an alternate location for the returned data
    #
    # @param [String] url The expected alternate URL value
    #
    # @return [Boolean] True if Content-Location matches expected value
    #
    # Example:
    #   assert_header_content_location('/index.htm')
    #
    def assert_header_content_location(url)
      assert_header('Content-Location', url.to_s)
    end

    # Tests that the Content-Type header matches an expected value
    # Content-Type specifies the MIME type of the content being sent
    #
    # @param [String] type The expected MIME type
    #
    # @return [Boolean] True if Content-Type matches expected value
    #
    # Example:
    #   assert_header_content_type('text/html; charset=utf-8')
    #
    def assert_header_content_type(type)
      assert_header('Content-Type', type)
    end

    # Tests that the ETag header matches an expected value
    # ETag is a unique identifier for a specific version of a resource, often a hash
    #
    # @param [String] tag The expected ETag value
    #
    # @return [Boolean] True if ETag matches expected value
    #
    # Example:
    #   assert_header_etag('"737060cd8c284d8af7ad3082f209582d"')
    #
    def assert_header_etag(tag)
      assert_header('ETag', tag)
    end

    # Tests that the Expires header matches an expected timestamp
    # Expires defines when the response should be considered stale
    #
    # @param [String] timestamp The expected expiration date in HTTP-date format
    #
    # @return [Boolean] True if Expires matches expected timestamp
    #
    # Example:
    #   assert_header_expires('Thu, 01 Dec 1994 16:00:00 GMT')
    #
    def assert_header_expires(timestamp)
      assert_header('Expires', timestamp)
    end

    # Tests that the Content-Type header matches an image MIME type
    # Validates that content is an image with the specified format
    #
    # @param [String, Symbol] type The expected image format (bmp, gif, jpg, jpeg, png, tiff)
    #
    # @return [Boolean] True if Content-Type matches "image/type"
    #
    # Example:
    #   assert_header_image_type('png')
    #   # Tests Content-Type equals 'image/png'
    #
    def assert_header_image_type(type)
      assert_header('Content-Type', "image/#{type}")
    end

    # Tests that the Last-Modified header matches an expected timestamp
    # Last-Modified indicates when the resource was last changed
    #
    # @param [String] timestamp The expected last modified date in HTTP-date format
    #
    # @return [Boolean] True if Last-Modified matches expected timestamp
    #
    # Example:
    #   assert_header_last_modified('Tue, 15 Nov 1994 12:45:26 GMT')
    #
    def assert_header_last_modified(timestamp)
      assert_header('Last-Modified', timestamp)
    end

    # Tests that the Server header matches an expected value
    # Server specifies information about the software used by the origin server
    #
    # @param [String] server_str The expected server identification string
    #
    # @return [Boolean] True if Server header matches expected value
    #
    # Example:
    #   assert_header_server('Apache/2.4.1 (Unix)')
    #
    def assert_header_server(server_str)
      assert_header('Server', server_str)
    end

    # Test for the `text/` type header via `Content-Type`
    # Tests that the Content-Type header matches a text/* MIME type
    #
    # @param [String] type The text content-type suffix (e.g. "plain", "html")
    #
    # @return [Boolean] True if Content-Type header matches "text/type"
    #
    # Example:
    #   assert_header_text_type('plain')
    #   # Tests Content-Type equals 'text/plain'
    #
    def assert_header_text_type(type)
      assert_header('Content-Type', "text/#{type}")
    end

    # Tests that the WWW-Authenticate header matches an expected value
    # WWW-Authenticate indicates the authentication scheme that should be used
    # to access the requested resource
    #
    # @param [String] auth_str The expected authentication scheme value
    #
    # @return [Boolean] True if WWW-Authenticate matches expected value
    #
    # Example:
    #   assert_header_www_authenticate('Basic')
    #   assert_header_www_authenticate('Bearer realm="example"')
    #
    def assert_header_www_authenticate(auth_str)
      assert_header('WWW-Authenticate', auth_str)
    end

    # Tests that the Content-Disposition header indicates an attachment download
    # Content-Disposition suggests whether content should be displayed inline or downloaded
    # as an attachment with an optional filename
    #
    # Raise a "File Download" dialogue box for a known MIME type with binary format or suggest
    # a filename for dynamic content. Quotes are necessary with special characters
    #
    # @param [String] filename The suggested filename for the attachment
    #
    # @return [Boolean] True if Content-Disposition matches expected attachment format
    #
    # Example:
    #   assert_header_attachment('document.pdf')
    #   # Tests Content-Disposition equals 'attachment; filename="document.pdf"'
    #
    def assert_header_attachment(filename)
      assert_header('Content-Disposition', "attachment; filename=\"#{filename}\"")
    end

    # Tests that the Content-Type header is set to "application/json"
    # Validates that the response is formatted as JSON data
    #
    # @return [Boolean] True if Content-Type matches "application/json"
    #
    # Example:
    #   assert_header_type_is_json
    #   # Tests Content-Type equals 'application/json'
    #
    def assert_header_type_is_json
      assert_header('Content-Type', 'application/json')
    end
  end
  # /module Assertions

  # add support for Spec syntax
  module Expectations
    infect_an_assertion :assert_header_accept, :must_have_header_accept, :reverse
    infect_an_assertion :assert_header_application_type, :must_have_header_application_type,
                        :reverse
    infect_an_assertion :assert_header_content_encoding, :must_have_header_content_encoding,
                        :reverse
    infect_an_assertion :assert_header_content_language, :must_have_header_content_language,
                        :reverse
    infect_an_assertion :assert_header_content_length, :must_have_header_content_length,
                        :reverse
    infect_an_assertion :assert_header_content_location, :must_have_header_content_location,
                        :reverse
    infect_an_assertion :assert_header_content_type, :must_have_header_content_type,
                        :reverse
    infect_an_assertion :assert_header_etag, :must_have_header_etag, :reverse
    infect_an_assertion :assert_header_expires, :must_have_header_expires, :reverse
    infect_an_assertion :assert_header_image_type, :must_have_header_image_type,
                        :reverse
    infect_an_assertion :assert_header_last_modified, :must_have_header_last_modified,
                        :reverse
    infect_an_assertion :assert_header_server, :must_have_header_server, :reverse
    infect_an_assertion :assert_header_text_type, :must_have_header_text_type, :reverse
    infect_an_assertion :assert_header_www_authenticate, :must_have_header_www_authenticate,
                        :reverse
    infect_an_assertion :assert_header_attachment, :must_have_header_attachment, :reverse
    infect_an_assertion :assert_header_type_is_json, :must_have_header_type_as_json, :reverse
  end
end
