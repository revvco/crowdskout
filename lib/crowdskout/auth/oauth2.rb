#
# oauth2.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Auth
    class OAuth2
      attr_accessor :client_id, :client_secret, :redirect_uri, :props


      # Class constructor
      # @param [Hash] opts - the options to create an OAuth2 object with
      # @option opts [String] :api_key - the Crowdskout API Key
      # @option opts [String] :api_secret - the Crowdskout secret key
      # @option opts [String] :redirect_url - the URL where Crowdskout is returning the authorization code
      # @return
      def initialize(opts = {})
        @client_id = opts[:api_key] || Util::Config.get('auth.api_key')
        @client_secret = opts[:api_secret] || Util::Config.get('auth.api_secret')
        @redirect_uri = opts[:redirect_url] || Util::Config.get('auth.redirect_uri')
        if @client_id.nil? || @client_id == '' || @client_secret.nil? || @client_secret.nil? || @redirect_uri.nil? || @redirect_uri == ''
          raise ArgumentError.new "Either api_key, api_secret or redirect_uri is missing in explicit call or configuration."
        end
      end


      # Get the URL at which the user can authenticate and authorize the requesting application
      # @param [String] state - an optional value used by the client to maintain state between the request and callback
      # @return [String] the authorization URL
      def get_authorization_url(state = nil)
        response_type = Util::Config.get('auth.response_type_code')
        params = {
          :response_type => response_type,
          :client_id     => @client_id,
          :redirect_uri  => @redirect_uri
        }
        if state
            params[:state] = state
        end
        [
          Util::Config.get('auth.base_url'),
          Util::Config.get('auth.authorization_endpoint'),
          '?',
          Util::Helpers.http_build_query(params)
        ].join
      end


      # Obtain an access token
      # @param [String] code - the code returned from Crowdskout after a user has granted access to his account
      # @return [String] the access token
      def get_access_token(code)
        params = {
          :grant_type    => Util::Config.get('auth.authorization_code_grant_type'),
          :client_id     => @client_id,
          :client_secret => @client_secret,
          :code          => code,
          :redirect_uri  => @redirect_uri
        }

        url = [
          Util::Config.get('auth.base_url'),
          Util::Config.get('auth.token_endpoint')
        ].join

        response_body = ''
        begin
          response = RestClient.post(url, params)
          response_body = JSON.parse(response)
        rescue => e
          response_body = e.respond_to?(:response) && e.response ?
            JSON.parse(e.response) :
            {'error' => '', 'error_description' => e.message}
        end

        if response_body['error_description']
          error = response_body['error_description']
          raise Exceptions::OAuth2Exception, error
        end

        response_body
      end
    end
  end
end