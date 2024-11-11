# frozen_string_literal: true

require 'rack/test'
require 'minitest/assertions'
require 'minitest/spec'

# reopening to add validations functionality
module Minitest
  # add support for Assert syntax
  module Assertions
    # Tests that the HTTP response status matches the expected value.
    #
    # @param status [Integer] the expected HTTP status code
    #
    # @return [Boolean] true if the status matches, false otherwise
    #
    # @example
    #   assert_status(200) # passes if response status is 200 OK
    #   assert_status(404) # passes if response status is 404 Not Found
    #
    def assert_status(status)
      msg = "Expected response status to be '#{status}', but was '#{last_response.status}'"

      assert_equal(status, last_response.status, msg)
    end

    ## 2xx SUCCCESS

    # Tests that the HTTP response status is 200 OK.
    #
    # @return [Boolean] true if the response status is 200 OK
    #
    # @example
    #   assert_ok # passes if response status is 200 OK
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-200-ok
    #
    def assert_ok
      assert_status 200
    end

    # Tests that the HTTP response status is 201 Created.
    #
    # @return [Boolean] true if the response status is 201 Created
    #
    # @example
    #   assert_created # passes if response status is 201 Created
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-201-created
    #
    def assert_created
      assert_status 201
    end

    # Tests that the HTTP response status is 202 Accepted.
    # The request has been accepted but has not been processed yet.
    #
    # NOTE! This code does not guarantee that the request will process successfully.
    #
    # @return [Boolean] true if the response status is 202 Accepted
    #
    # @example
    #   assert_accepted # passes if response status is 202 Accepted
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-202-accepted
    #
    def assert_accepted
      assert_status 202
    end

    # Tests that the HTTP response status is 204 No Content.
    # The server accepted the request but is not returning any content.
    # This is often used as a response to a DELETE request.
    #
    # @return [Boolean] true if the response status is 204 No Content
    #
    # @example
    #   assert_no_content # passes if response status is 204 No Content
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-204-no-content
    #
    def assert_no_content
      assert_status 204
    end

    # Tests that the HTTP response status is 205 Reset Content.
    #
    # The server accepted the request but requires the client to reset the document view.
    # Similar to a 204 No Content response but this response requires the requester
    # to reset the document view.
    #
    # @return [Boolean] true if the response status is 205 Reset Content
    #
    # @example
    #   assert_reset_content # passes if response status is 205 Reset Content
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-205-reset-content
    #
    def assert_reset_content
      assert_status 205
    end

    # Tests that the HTTP response status is 206 Partial Content.

    # The server is delivering only a portion of the content, as requested by the client
    # via a range header.
    #
    # @return [Boolean] true if the response status is 206 Partial Content
    #
    # @example
    #   assert_partial_content # passes if response status is 206 Partial Content
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-206-partial-content
    #
    def assert_partial_content
      assert_status 206
    end

    ## 3xx REDIRECTION

    # Tests that the HTTP response status is 300 Multiple Choices.
    # Indicates multiple options for the user to follow. This can happen when the server
    # has several suitable responses and the client must select one themselves.
    #
    # @return [Boolean] true if the response status is 300 Multiple Choices
    #
    # @example
    #   assert_multiple_choices # passes if response status is 300 Multiple Choices
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-300-multiple-choices
    #
    def assert_multiple_choices
      assert_status 300
    end

    # Tests that the HTTP response status is 301 Moved Permanently.
    # The resource has been moved and all further requests should reference its new URI.
    #
    # @return [Boolean] true if the response status is 301 Moved Permanently
    #
    # @example
    #   assert_moved_permanently # passes if response status is 301 Moved Permanently
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-301-moved-permanently
    #
    def assert_moved_permanently
      assert_status 301
    end

    # Tests that the HTTP response status is 302 Found.
    # The HTTP 1.0 specification described this status as "Moved Temporarily",
    # but popular browsers respond to this status similar to behavior intended for 303.
    # The resource can be retrieved by referencing the returned URI.
    #
    # @return [Boolean] true if the response status is 302 Found
    #
    # @example
    #   assert_found # passes if response status is 302 Found
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-302-found
    #
    def assert_found
      assert_status 302
    end

    # Tests that the HTTP response status is 304 Not Modified.
    # The resource has not been modified since the version specified in
    # If-Modified-Since or If-Match headers.
    # The resource will not be returned in response body.
    #
    # @return [Boolean] true if the response status is 304 Not Modified
    #
    # @example
    #   assert_not_modified # passes if response status is 304 Not Modified
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-304-not-modified
    #
    def assert_not_modified
      assert_status 304
    end

    # Tests that the HTTP response status is 305 Use Proxy.
    # Indicates that the requested resource can only be accessed through a proxy
    # specified in the response's Location header.
    #
    # @return [Boolean] true if the response status is 305 Use Proxy
    #
    # @example
    #   assert_use_proxy # passes if response status is 305 Use Proxy
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-305-use-proxy
    #
    def assert_use_proxy
      assert_status 305
    end

    # Tests that the HTTP response status is 306 Switch Proxy.
    # This status code is no longer used. Originally meant to indicate that subsequent
    # requests should use the specified proxy.
    #
    # NOTE: This code is deprecated in HTTP 1.1 and should not be used.
    #
    # @return [Boolean] true if the response status is 306 Switch Proxy
    #
    # @example
    #   assert_switch_proxy # passes if response status is 306 Switch Proxy
    #
    # @deprecated No longer used in HTTP 1.1
    #
    def assert_switch_proxy
      assert_status 306
    end

    # Tests that the HTTP response status is 307 Temporary Redirect.
    # HTTP 1.1. The request should be repeated with the URI provided in the response,
    # but future requests should still call the original URI.
    #
    # @return [Boolean] true if the response status is 307 Temporary Redirect
    #
    # @example
    #   assert_temporary_redirect # passes if response status is 307 Temporary Redirect
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-307-temporary-redirect
    #
    def assert_temporary_redirect
      assert_status 307
    end

    # Tests that the HTTP response status is 308 Permanent Redirect.
    # Experimental. The request and all future requests should be repeated with the URI
    # provided in the response.
    # The HTTP method is not allowed to be changed in the subsequent request.
    #
    # @return [Boolean] true if the response status is 308 Permanent Redirect
    #
    # @example
    #   assert_permanent_redirect # passes if response status is 308 Permanent Redirect
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-308-permanent-redirect
    #
    def assert_permanent_redirect
      assert_status 308
    end

    ## 4XX CLIENT ERROR

    # Tests that the HTTP response status is 400 Bad Request.
    # The request could not be fulfilled due to the incorrect syntax of the request.
    # This indicates that the request was malformed, contains invalid syntax,
    # or cannot be processed by the server.
    #
    # @return [Boolean] true if the response status is 400 Bad Request
    #
    # @example
    #   assert_bad_request # passes if response status is 400 Bad Request
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request
    #
    def assert_bad_request
      assert_status 400
    end

    # Tests that the HTTP response status is 401 Unauthorized.
    # The requester is not authorized to access the resource. This status code is used when
    # authentication is required but has either failed or not been provided. Similar to 403
    # Forbidden, but indicates specifically that authentication is possible.
    #
    # @return [Boolean] true if the response status is 401 Unauthorized
    #
    # @example
    #   assert_unauthorized # passes if response status is 401 Unauthorized
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-401-unauthorized
    #
    def assert_unauthorized
      assert_status 401
    end

    # Tests that the HTTP response status is 403 Forbidden.
    # The request was formatted correctly but the server is refusing to supply
    # the requested resource.
    # Unlike 401, authenticating will not make a difference in the server's response.
    #
    # @return [Boolean] true if the response status is 403 Forbidden
    #
    # @example
    #   assert_forbidden # passes if response status is 403 Forbidden
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-403-forbidden
    #
    def assert_forbidden
      assert_status 403
    end

    # Tests that the HTTP response status is 404 Not Found.
    # The resource could not be found. This is often used as a catch-all for all invalid URIs
    # requested of the server.
    #
    # @return [Boolean] true if the response status is 404 Not Found
    #
    # @example
    #   assert_not_found # passes if response status is 404 Not Found
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-404-not-found
    #
    def assert_not_found
      assert_status 404
    end

    # Tests that the HTTP response status is 405 Method Not Allowed.
    # The resource was requested using a method that is not allowed.
    # For example, requesting a resource via a POST method when the resource only supports GET.
    #
    # @return [Boolean] true if the response status is 405 Method Not Allowed
    #
    # @example
    #   assert_method_not_allowed # passes if response status is 405 Method Not Allowed
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-405-method-not-allowed
    #
    def assert_method_not_allowed
      assert_status 405
    end

    # Tests that the HTTP response status is 406 Not Acceptable.
    # The resource is valid, but cannot be provided in a format specified in the Accept headers
    # in the request.
    #
    # The server sends this error when the client requests a format that the server
    # does not support.
    #
    # @return [Boolean] true if the response status is 406 Not Acceptable
    #
    # @example
    #   assert_not_acceptable # passes if response status is 406 Not Acceptable
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-406-not-acceptable
    #
    def assert_not_acceptable
      assert_status 406
    end

    # Tests that the HTTP response status is 407 Proxy Authentication Required.
    # Authentication is required with the proxy before requests can be fulfilled.
    # The proxy server must return information about the authentication scheme required
    # in a Proxy-Authenticate header.
    #
    # @return [Boolean] true if the response status is 407 Proxy Authentication Required
    #
    # @example
    #   assert_proxy_authentication_required # passes if response status is 407
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-407-proxy-authentication-re
    #
    def assert_proxy_authentication_required
      assert_status 407
    end

    # Tests that the HTTP response status is 408 Request Timeout.
    # The server timed out waiting for a request from the client.
    # The client is allowed to repeat the request.
    #
    # @return [Boolean] true if the response status is 408 Request Timeout
    #
    # @example
    #   assert_request_timeout # passes if response status is 408 Request Timeout
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-408-request-timeout
    #
    def assert_request_timeout
      assert_status 408
    end

    # Tests that the HTTP response status is 415 Unsupported Media Type.
    # The client provided data with a media type that the server does not support.
    # For example, submitting JSON data when only XML is supported.
    #
    # @return [Boolean] true if the response status is 415 Unsupported Media Type
    #
    # @example
    #   assert_unsupported_media_type # passes if response status is 415 Unsupported Media Type
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-415-unsupported-media-type
    #
    def assert_unsupported_media_type
      assert_status 415
    end

    # Tests that the HTTP response status is 422 Unprocessable Entity.
    # The request was well-formed but was unable to be processed due to semantic errors.
    # Commonly used when validation fails or malformed content is submitted.
    #
    # @return [Boolean] true if the response status is 422 Unprocessable Entity
    #
    # @example
    #   assert_unprocessable_entity # passes if response status is 422 Unprocessable Entity
    #
    # @see https://www.rfc-editor.org/rfc/rfc4918#section-11.2
    #
    def assert_unprocessable_entity
      assert_status 422
    end

    # Tests that the HTTP response status is 429 Too Many Requests.
    # The user has sent too many requests in a given amount of time ("rate limiting").
    # This status indicates that the client should retry after some time.
    #
    # @return [Boolean] true if the response status is 429 Too Many Requests
    #
    # @example
    #   assert_too_many_requests # passes if response status is 429 Too Many Requests
    #
    # @see https://www.rfc-editor.org/rfc/rfc6585#section-4
    #
    def assert_too_many_requests
      assert_status 429
    end

    ## 5XX SERVER ERROR

    # Tests that the HTTP response status is 500 Internal Server Error.
    # A generic status for an error in the server itself. This indicates that the server
    # encountered an unexpected condition that prevented it from fulfilling the request.
    #
    # @return [Boolean] true if the response status is 500 Internal Server Error
    #
    # @example
    #   assert_internal_server_error # passes if response status is 500 Internal Server Error
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-500-internal-server-error
    #
    def assert_internal_server_error
      assert_status 500
    end

    # Tests that the HTTP response status is 501 Not Implemented.
    # The server cannot respond to the request. This usually implies that the server could
    # possibly support the request in the future — otherwise a 4xx status may be more appropriate.
    #
    # @return [Boolean] true if the response status is 501 Not Implemented
    #
    # @example
    #   assert_not_implemented # passes if response status is 501 Not Implemented
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-501-not-implemented
    #
    def assert_not_implemented
      assert_status 501
    end

    # Tests that the HTTP response status is 502 Bad Gateway.
    # The server is acting as a proxy and did not receive an acceptable response from
    # the upstream server. This indicates that the proxy server was unable to complete
    # the request due to issues with the upstream server.
    #
    # @return [Boolean] true if the response status is 502 Bad Gateway
    #
    # @example
    #   assert_bad_gateway # passes if response status is 502 Bad Gateway
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-502-bad-gateway
    #
    def assert_bad_gateway
      assert_status 502
    end

    # Tests that the HTTP response status is 503 Service Unavailable.
    # The server is currently unavailable (because it is overloaded or down for maintenance).
    # Generally, this is a temporary state and the server should return information about when
    # to retry with a Retry-After header.
    #
    # @return [Boolean] true if the response status is 503 Service Unavailable
    #
    # @example
    #   assert_service_unavailable # passes if response status is 503 Service Unavailable
    #
    # @see https://www.rfc-editor.org/rfc/rfc9110.html#name-503-service-unavailable
    #
    def assert_service_unavailable
      assert_status 503
    end

    # Tests that the HTTP response status is 508 Loop Detected.
    # The server detected an infinite loop while processing the request. This error occurs
    # when the server detects that the client's request would result in an infinite loop
    # of operations, typically in WebDAV scenarios.
    #
    # @return [Boolean] true if the response status is 508 Loop Detected
    #
    # @example
    #   assert_loop_detected # passes if response status is 508 Loop Detected
    #
    # @see https://www.rfc-editor.org/rfc/rfc5842
    #
    def assert_loop_detected
      assert_status 508
    end
  end
  # /module Assertions

  # add support for Spec syntax
  module Expectations
    infect_an_assertion :assert_ok, :must_be_ok, :reverse
    infect_an_assertion :assert_created, :must_be_created, :reverse
    infect_an_assertion :assert_accepted, :must_be_accepted, :reverse
    infect_an_assertion :assert_no_content, :must_be_no_content, :reverse
    infect_an_assertion :assert_moved_permanently, :must_be_moved_permanently, :reverse
    infect_an_assertion :assert_bad_request, :must_be_bad_request, :reverse
    infect_an_assertion :assert_unauthorized, :must_be_unauthorized, :reverse
    infect_an_assertion :assert_forbidden, :must_be_forbidden, :reverse
    infect_an_assertion :assert_not_found, :must_be_not_found, :reverse
    infect_an_assertion :assert_method_not_allowed, :must_be_method_not_allowed, :reverse
    infect_an_assertion :assert_not_acceptable, :must_be_not_acceptable, :reverse
    infect_an_assertion :assert_request_timeout, :must_be_request_timeout, :reverse
    infect_an_assertion :assert_unsupported_media_type, :must_be_unsupported_media_type, :reverse
    infect_an_assertion :assert_unprocessable_entity, :must_be_unprocessable_entity, :reverse
    infect_an_assertion :assert_too_many_requests, :must_be_too_many_requests, :reverse
    infect_an_assertion :assert_internal_server_error, :must_be_internal_server_error, :reverse
    infect_an_assertion :assert_not_implemented, :must_be_not_implemented, :reverse
    infect_an_assertion :assert_bad_gateway, :must_be_bad_gateway, :reverse
    infect_an_assertion :assert_service_unavailable, :must_be_service_unavailable, :reverse
    infect_an_assertion :assert_loop_detected, :must_be_loop_detected, :reverse
  end
end
