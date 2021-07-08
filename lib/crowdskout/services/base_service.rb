#
# attribute_service.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Services
    class BaseService
      attr_accessor :api_key, :access_token

      attr_accessor :api_key
      def initialize(api_key = nil, access_token = nil)
        @api_key = api_key
        @access_token = access_token
      end
      protected

      # Return required headers for making an http request with Crowdskout
      # @param [String] content_type - The MIME type of the body of the request, default is 'application/json'
      # @return [Hash] - authorization headers
      def get_headers(content_type = 'application/json')
        {
          :content_type   => content_type,
          :accept         => 'application/json',
          :authorization  => "Bearer #{@access_token}",
          :user_agent     => "AppConnect Ruby SDK v#{Crowdskout::VERSION} (#{RUBY_DESCRIPTION})",
          :x_ctct_request_source => "sdk.ruby.#{Crowdskout::VERSION}"
        }
      end

      # Build a url from the base url and query parameters hash. Query parameters
      # should not be URL encoded because this method will handle that
      # @param [String] url - The base url
      # @param [Hash] params - A hash with query parameters
      # @return [String] - the url with query parameters hash
      def build_url(url, params = nil)
        if params.respond_to? :each
          params.each do |key, value|
            # Convert dates to CC date format
            if value.respond_to? :iso8601
              params[key] = value.iso8601
            end

            if key.to_s == 'next' && value.match(/^.*?next=(.*)$/)
              params[key] = $1
            end
          end
        else
          params ||= {}
        end

        params['api_key'] = @api_key
        url += '?' + Util::Helpers.http_build_query(params)
      end

    end
  end
end
