module Minitest
  module Rack
    module Headers
      
      module Assertions

        # shortcut for testing the last_response.header value
        def assert_header(header, contents)
          assert_equal(contents, last_response.header[header], "Expected response header '#{header}' to be '#{contents}', but was '#{last_response.header[header]}'")
        end
     
        # Accept - Content-Types that are acceptable for the response
        # 
        #    Accept: text/plain
        # 
        def assert_header_accept(type)
          assert_header("Accept", type)
        end

        # Test for the `application/` type header via `Content-Type`
        # 
        #   Content-Type: application/pdf
        # 
        def assert_header_application_type(type)
          assert_header("Content-Type", "application/#{type}")
        end

        # Content-Encoding - The type of encoding used on the data
        # 
        #   Content-Encoding: gzip
        # 
        def assert_header_content_encoding(encoding_str)
          assert_header("Content-Encoding", encoding_str)
        end
        alias :assert_header_content_encoding, :assert_header_encoding 

        # Content-Language - The language the content is in
        # 
        #   Content-Language: en
        # 
        def assert_header_content_language(lang)
          assert_header("Content-Language", lang)
        end

        # Content-Length - The length of the response body in octets (8-bit bytes)
        #
        #    Content-Length: 348
        # 
        def assert_header_content_length(length)
          assert_header("Content-Length", length)
        end

        # Content-Location - An alternate location for the returned data
        # 
        #   Content-Location: /index.htm
        # 
        def assert_header_content_location(url)
          assert_header("Content-Location", url)
        end
                
        # Content-Type - The MIME type of this content
        # 
        #   Content-Type: text/html; charset=utf-8
        # 
        def assert_header_content_type(type)
          assert_header("Content-Type", type)
        end

        # ETag - An identifier for a specific version of a resource, often a message digest
        # 
        #     ETag: "737060cd8c284d8af7ad3082f209582d"
        # 
        def assert_header_etag(tag)
          assert_header("ETag", tag)
        end

        # Expires - Gives the date/time after which the response is considered stale
        # 
        #    Expires: Thu, 01 Dec 1994 16:00:00 GMT
        # 
        def assert_header_expires(timestamp)
          assert_header("Expires", timestamp)
        end

        # Test for the image type header via `Content-Type`
        # Valid Types:  [:bmp, :gif, :jpg, :jpeg, :png, :tiff]
        # 
        #   Content-Type: image/png
        # 
        def assert_header_image_type(type)
          valid_types = [:bmp,:gif,:jpg,:jpeg,:png,:tiff]
          assert_header("Content-Type", "image/#{type}")
        end

        # The last modified date for the requested object (in HTTP-date format as defined by RFC 2616)
        # 
        #    Last-Modified: Tue, 15 Nov 1994 12:45:26 GMT
        # 
        def assert_header_last_modified(timestamp)
          assert_header("Last-Modified", timestamp)
        end

        # Server  -  A name for the server
        # 
        #   Server: Apache/2.4.1 (Unix)
        # 
        def assert_header_server(server_str)
          assert_header("Server", server_str)
        end

        # Test for the `text/` type header via `Content-Type`
        # 
        #   Content-Type: text/pdf
        # 
        def assert_header_text_type(type)
          assert_header("Content-Type", "text/#{type}")
        end

        # WWW-Authenticate - Indicates the authentication scheme that should be used to access the requested entity
        # 
        #    WWW-Authenticate: Basic
        # 
        def assert_header_www_authenticate(auth_str)
          assert_header("WWW-Authenticate", auth_str)
        end

        # Content-Disposition
        # An opportunity to raise a "File Download" dialogue box for a known MIME type with binary format 
        # or suggest a filename for dynamic content. Quotes are necessary with special characters
        # 
        #   Content-Disposition: attachment; filename="fname.ext"
        # 
        def assert_header_attachment(filename)
          assert_header("Content-Disposition", "attachment; filename=\"#{filename}\"")
        end

        def assert_header_type_is_json
          assert_header("Content-Type", "application/json")
        end
        
      end

      module Expectations
        
      end

    end
  end
end

# include the assertions into Minitest
class Minitest::Test
  include Minitest::Rack::Headers::Assertions
  # include Minitest::Rack::Headers::Expectations
end
