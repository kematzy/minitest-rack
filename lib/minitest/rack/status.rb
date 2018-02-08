module Minitest
  module Rack
    module Status
      module Assertions
        
        # shortcut for testing the last_response.status value
        def assert_status(status)
          assert_equal(status, last_response.status, "Expected response status to be '#{status}', but was '#{last_response.status}'")
        end

        ## 2xx SUCCCESS

        # 200 OK
        # The standard response for successful HTTP requests.
        def assert_ok
          assert_status 200
        end
        
        # 201 Created
        # The request has been fulfilled and a new resource has been created.
        def assert_created
          assert_status 201
        end
        
        # 202 Accepted
        # The request has been accepted but has not been processed yet. 
        # NOTE! This code does not guarantee that the request will process successfully.
        def assert_accepted
          assert_status 202
        end
        
        # 204 No content
        # The server accepted the request but is not returning any content. 
        # This is often used as a response to a DELETE request.
        def assert_no_content
          assert_status 204
        end
  
        # 205 Reset content
        # Similar to a 204 No Content response but this response requires the requester to reset the document view.
        def assert_reset_content
          assert_status 205
        end
        
        # 206 Partial content
        # The server is delivering only a portion of the content, as requested by the client via a range header.
        def assert_partial_content
          assert_status 206
        end

        ## 3xx REDIRECTION

        # 300 Multiple choices
        # There are multiple options that the client may follow.
        def assert_multiple_choices
          assert_status 300
        end

        # 301 Moved permanently
        # The resource has been moved and all further requests should reference its new URI.
        def assert_moved_permanently
          assert_status 301
        end
        
        # 302 Found
        # The HTTP 1.0 specification described this status as "Moved Temporarily", 
        # but popular browsers respond to this status similar to behavior intended for 303. 
        # The resource can be retrieved by referencing the returned URI.
        def assert_found
          assert_status 302
        end
        
        # 304 Not modified
        # The resource has not been modified since the version specified in `If-Modified-Since`` or `If-Match`` headers. 
        # The resource will not be returned in response body.
        def assert_not_modified
          assert_status 304
        end

        # 305 Use proxy
        # HTTP 1.1. The resource is only available through a proxy and the address is provided in the response.
        def assert_use_proxy
          assert_status 305
        end

        # 306 Switch proxy
        # Deprecated in HTTP 1.1. Used to mean that subsequent requests should be sent using the specified proxy.
        def assert_switch_proxy
          assert_status 306
        end
       
        # 307 Temporary redirect
        # HTTP 1.1. The request should be repeated with the URI provided in the response, 
        # but future requests should still call the original URI.
        def assert_temporary_redirect
          assert_status 307
        end

        # 308 Permanent redirect
        # Experimental. The request and all future requests should be repeated with the URI provided in the response. 
        # The HTTP method is not allowed to be changed in the subsequent request.
        def assert_permanent_redirect
          assert_status 308
        end

        ## 4XX CLIENT ERROR

        # 400 Bad request
        # The request could not be fulfilled due to the incorrect syntax of the request.
        def assert_bad_request
          assert_status 400
        end

        # 401 Unauthorized
        # The requester is not authorized to access the resource. This is similar to 403 but is used in cases 
        # where authentication is expected but has failed or has not been provided.
        def assert_unauthorized
          assert_status 401
        end

        # 403 Forbidden
        # The request was formatted correctly but the server is refusing to supply the requested resource. Unlike 401,
        # authenticating will not make a difference in the server's response.
        def assert_forbidden
          assert_status 403
        end

        # 404 Not found
        # The resource could not be found. This is often used as a catch-all for all invalid URIs requested of the server.
        def assert_not_found
          assert_status 404
        end

        # 405 Method not allowed
        # The resource was requested using a method that is not allowed. 
        # For example, requesting a resource via a POST method when the resource only supports the GET method.
        def assert_method_not_allowed
          assert_status 405
        end

        # 406 Not acceptable
        # The resource is valid, but cannot be provided in a format specified in the Accept headers in the request.
        def assert_not_acceptable
          assert_status 406
        end

        # 407 Proxy authentication required
        # Authentication is required with the proxy before requests can be fulfilled.
        def assert_proxy_authentication_required
          assert_status 407
        end

        # 408 Request timeout
        # The server timed out waiting for a request from the client. The client is allowed to repeat the request.
        def assert_request_timeout
          assert_status 408
        end

        # 415 Unsupported media type
        # The client provided data with a media type that the server does not support.
        def assert_unsupported_media_type
          assert_status 415
        end

        # 422 Unprocessable entity
        # The request was formatted correctly but cannot be processed in its current form. 
        # Often used when the specified parameters fail validation errors.  WebDAV - RFC 4918
        def assert_unprocessable_entity
          assert_status 422
        end
  
        # 429 Too many requests
        # The user has sent too many requests in a given amount of time ("rate limiting").
        # Additional HTTP Status Codes - RFC 6585
        def assert_too_many_requests
          assert_status 429
        end

        ## 5XX SERVER ERROR

        # 500 Internal server error
        # A generic status for an error in the server itself.
        def assert_internal_server_error
          assert_status 500
        end

        # 501 Not implemented
        # The server cannot respond to the request. This usually implies that the server could 
        # possibly support the request in the future — otherwise a 4xx status may be more appropriate.
        def assert_not_implemented
          assert_status 501
        end

        # 502 Bad gateway
        # The server is acting as a proxy and did not receive an acceptable response from the upstream server.
        def assert_bad_gateway
          assert_status 502
        end

        # 503 Service unavailable
        # The server is down and is not accepting requests.
        def assert_service_unavailable
          assert_status 503 
        end

        # 508 Loop detected
        # The server detected an infinite loop in the request. WebDAV - RFC 5842
        def assert_loop_detected
          assert_status 508
        end
  
      end


      module Expectations
        infect_an_assertion :assert_ok,                      :must_be_ok,                       :only_one_argument
        infect_an_assertion :assert_created,                 :must_be_created,                  :only_one_argument
        infect_an_assertion :assert_accepted,                :must_be_accepted,                 :only_one_argument
        infect_an_assertion :assert_no_content,              :must_be_no_content,               :only_one_argument
        infect_an_assertion :assert_moved_permanently,       :must_be_moved_permanently,        :only_one_argument

        infect_an_assertion :assert_bad_request,             :must_be_bad_request,              :only_one_argument
        infect_an_assertion :assert_unauthorized,            :must_be_unauthorized,             :only_one_argument
        infect_an_assertion :assert_forbidden,               :must_be_forbidden,                :only_one_argument
        infect_an_assertion :assert_not_found,               :must_be_not_found,                :only_one_argument
        infect_an_assertion :assert_method_not_allowed,      :must_be_method_not_allowed,       :only_one_argument
        infect_an_assertion :assert_not_acceptable,          :must_be_not_acceptable,           :only_one_argument
        infect_an_assertion :assert_method_not_allowed,      :must_be_method_not_allowed,       :only_one_argument
        infect_an_assertion :assert_request_timeout,         :must_be_request_timeout,          :only_one_argument
        infect_an_assertion :assert_unsupported_media_type,  :must_be_unsupported_media_type,   :only_one_argument
        infect_an_assertion :assert_unprocessable_entity,    :must_be_unprocessable_entity,     :only_one_argument
        infect_an_assertion :assert_too_many_requests,       :must_be_too_many_requests,        :only_one_argument

        infect_an_assertion :assert_internal_server_error,   :must_be_internal_server_error,    :only_one_argument
        infect_an_assertion :assert_not_implemented,         :must_be_not_implemented,          :only_one_argument 
        infect_an_assertion :assert_bad_gateway,             :must_be_bad_gateway,              :only_one_argument 
        infect_an_assertion :assert_service_unavailable,     :must_be_service_unavailable,      :only_one_argument
        infect_an_assertion :assert_loop_detected,           :must_be_loop_detected,            :only_one_argument
      end
    end
  end
end

# include the assertions into Minitest
class Minitest::Test
  include Minitest::Rack::Status::Assertions
  # include Minitest::Rack::Status::Expectations
end
