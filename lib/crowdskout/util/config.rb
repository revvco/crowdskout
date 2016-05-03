module Crowdskout
  module Util
    class Config

      # Return a hash of configuration strings
      # @return [Hash] - hash of configuration properties
      @props = {
        # REST endpoints
        :endpoints => {
          :base_url                       => 'https://api.crowdskout.com/v1/',

          :profile                        => 'profile',
          :crud_profile                   => 'profile/%s',
          :profile_bulk                   => 'profile/bulk',

          :fields_options                 => 'fields/%s/options',

          :attributes                     => 'attributes',
          :attribute                      => 'attribute',
          :crud_attribute                 => 'attribute/%s'
        },

        # OAuth2 Authorization related configuration options
        :auth => {
          :base_url                      => 'https://api.crowdskout.com/oauth/',
          :response_type_code            => 'code',
          :authorization_code_grant_type => 'authorization_code',
          :authorization_endpoint        => 'authorize',
          :token_endpoint                => 'access_token',
          :api_key                       => '',
          :api_secret                    => '',
          :redirect_uri                  => ''
        },

        # Errors to be returned for various exceptions
        :errors => {
          :api_key_missing      => 'api_key required either explicitly or in configuration.',
          :access_token_missing => 'access_token required explicitly.',
          :api_secret_missing   => 'The api_secret is missing in explicit call or configuration.'
        }
      }

      class << self
        attr_accessor :props

         def configure 
          yield props if block_given?
        end

        # Get a configuration property given a specified location, example usage: Config::get('auth.token_endpoint')
        # @param [String] index - location of the property to obtain
        # @return [String]
        def get(index)
          properties = index.split('.')
          get_value(properties, props)
        end

        private

        # Navigate through a config array looking for a particular index
        # @param [Array] index The index sequence we are navigating down
        # @param [Hash, String] value The portion of the config array to process
        # @return [String]
        def get_value(index, value)
          index = index.is_a?(Array) ? index : [index]
          key = index.shift.to_sym
          value.is_a?(Hash) and value[key] and value[key].is_a?(Hash) ?
          get_value(index, value[key]) :
          value[key]
        end
      end

    end
  end
end