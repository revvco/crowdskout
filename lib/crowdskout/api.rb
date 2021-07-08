#
# api.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  class Api
    # Class constructor
    # @param [String] api_key - Crowdskout API Key
    # @param [String] access_token - Crowdskout OAuth2 access token
    # @return
    def initialize(api_key = nil, access_token = nil))
      @api_key = api_key || Util::Config.get('auth.api_key')
      @access_token = access_token
      if @api_key.nil? || @api_key == ''
        raise ArgumentError.new(Util::Config.get('errors.api_key_missing'))
      end
      if @access_token.nil? || @access_token == ''
        raise ArgumentError.new(Util::Config.get('errors.access_token_missing'))
      end
    end

    # Profile Service Methods
    def get_profile(profile_id, collections)
      Services::ProfileService.new(api_key, access_token).get_profile(profile_id, collections)
    end
    def create_profile(profile)
      Services::ProfileService.new(api_key, access_token).create_profile(profile)
    end
    def create_profiles_bulk(profiles)
      Services::ProfileService.new(api_key, access_token).create_profiles_bulk(profiles)
    end
    def update_profile(profile)
      Services::ProfileService.new(api_key, access_token).update_profile(profile)
    end
    def update_profiles_bulk(profiles)
      Services::ProfileService.new(api_key, access_token).update_profiles_bulk(profiles)
    end
    def check_for_non_match(profile)
      Services::ProfileService.new(api_key, access_token).check_for_non_match(profile)
    end

    # Fields Service Methods
    def get_options_for_a_field(field_name, params = {})
      Services::FieldService.new(api_key, access_token).get_options_for_a_field(field_name, params)
    end

    # Attribute Service Methods
    def get_attributes(params = {})
      Services::AttributeService.new(api_key, access_token).get_attributes(params)
    end
    def get_attribute(attribute_id, params = {})
      Services::AttributeService.new(api_key, access_token).get_attribute(attribute_id)
    end
    def create_attribute(name, type, options = nil)
      Services::AttributeService.new(api_key, access_token).create_attribute(name, type, options)
    end
    def update_attribute(attribute_id, params = {})
      Services::AttributeService.new(api_key, access_token).update_attribute(attribute_id, params)
    end
    def delete_attribute(attribute_id)
      Services::AttributeService.new(api_key, access_token).delete_attribute(attribute_id)
    end

    # Quartermaster Service Methods
    def tracking_code
      Services::QuartermasterService.new(api_key, access_token).tracking_code
    end
  end
end
