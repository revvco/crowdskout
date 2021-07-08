#
# field_service.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Services
    class FieldService < BaseService
      # more info - http://docs.crowdskout.com/api/#get-the-options-for-a-field
      # Get the options for a field
      # @param [String] field_name - the name of the field
      # @param [Hash] params - A hash with query parameters
      # @return [FieldOptions] - the field options
      def get_options_for_a_field(field_name, params = {})
        raise Exceptions::ServiceException, "Field name is required." if field_name.nil?
        url = Util::Config.get('endpoints.base_url') +
              sprintf(Util::Config.get('endpoints.fields_options'), field_name)
        url = build_url(url, params)
        response = RestClient.get(url, get_headers())
        Components::FieldOptions.create(JSON.parse(response.body)["data"])
      end
    end
  end
end
