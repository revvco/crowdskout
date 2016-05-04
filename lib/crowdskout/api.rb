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
    def initialize(api_key = nil, access_token = nil)
      Services::BaseService.api_key = api_key || Util::Config.get('auth.api_key')
      Services::BaseService.access_token = access_token
      if Services::BaseService.api_key.nil? || Services::BaseService.api_key == ''
        raise ArgumentError.new(Util::Config.get('errors.api_key_missing'))
      end
      if Services::BaseService.access_token.nil? || Services::BaseService.access_token == ''
        raise ArgumentError.new(Util::Config.get('errors.access_token_missing'))
      end
    end

    # Profile Service Methods
    def get_profile(profile_id, collections)
      Services::ProfileService.get_profile(profile_id, collections)
    end
    def create_profile(profile)
      Services::ProfileService.create_profile(profile, params)
    end
    def create_profiles_bulk(profiles)
      Services::ProfileService.create_profiles_bulk(profiles)
    end
    def update_profile(profile)
      Services::ProfileService.update_profile(profile)
    end
    def update_profiles_bulk(profiles)
      Services::ProfileService.update_profiles_bulk(profiles)
    end

    # Fields Service Methods
    def get_options_for_a_field(field_name, params = {})
      Services::FieldService.get_options_for_a_field(field_name, params)
    end

    # Attribute Service Methods
    def get_attributes(params = {})
      Services::AttributeService.get_attributes(params)
    end
    def get_attribute(attribute_id, params = {})
      Services::AttributeService.get_attribute(attribute_id)
    end
    def create_attribute(name, type, options = nil)
      Services::AttributeService.create_attribute(name, type, options)
    end
    def update_attribute(attribute_id, params = {})
      Services::AttributeService.update_attribute(attribute_id, params)
    end
    def delete_attribute(attribute_id)
      Services::AttributeService.delete_attribute(attribute_id)
    end
  end
end