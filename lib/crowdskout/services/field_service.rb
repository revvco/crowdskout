module Crowdskout
  module Services
    class FieldService < BaseService
      class << self
        # more info - http://docs.crowdskout.com/api/#get-the-options-for-a-field
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
end