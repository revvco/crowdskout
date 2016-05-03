module Crowdskout
  module Services
    class AttributeService < BaseService
      class << self

        # More info - http://docs.crowdskout.com/api/#get-all-attributes
        # @param params - query parameters
        #         - limit - the number of attributes to limit
        #         - offset - the number of attributes to skip        
        def get_attributes(params = {})
          url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.attributes')
          url = build_url(url, params)

          response = RestClient.get(url, get_headers())
          body = JSON.parse(response.body)

          attributes = []
          body['data']['list'].each do |attribute|
            attributes << Components::Attribute.create(attribute)
          end if body['data']["total"] > 0

          Components::ResultSet.new(attributes, body['messages'])
        end

        # more info - http://docs.crowdskout.com/api/#get-an-attribute-by-id
        # @param [Integration] attribute_id - the id of the attribute to fetch
        def get_attribute(attribute_id)
          raise Exceptions::ServiceException, "Attribute ID is required." if attribute_id.nil?
          url = Util::Config.get('endpoints.base_url') +
                sprintf(Util::Config.get('endpoints.crud_attribute'), attribute_id)
          url = build_url(url)
          response = RestClient.get(url, get_headers())
          Components::Attribute.create(JSON.parse(response.body)["data"])
        end

        # more info - http://docs.crowdskout.com/api/#create-an-attribute
        def create_attribute(new_attribute)
          raise Exceptions::ServiceException, "Attribute must not be nil" if new_attribute.nil?
          url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.attribute')
          url = build_url(url)
          payload = new_attribute.to_json
          response = RestClient.post(url, payload, get_headers())
          Components::Attribute.create(JSON.parse(response.body)["data"])
        end

        # more info - http://docs.crowdskout.com/api/#update-an-attribute
        def update_attribute(attribute_id, params = {})
          raise Exceptions::ServiceException, "Attribute ID is required." if attribute_id.nil?
          url = Util::Config.get('endpoints.base_url') + sprintf(Util::Config.get('endpoints.crud_attribute'), attribute_id)
          url = build_url(url)
          response = RestClient.put(url, params, get_headers())
          Components::Attribute.create(JSON.parse(response.body)["data"])
        end

        # more info - http://docs.crowdskout.com/api/#delete-an-attribute
        def delete_attribute(attribute_id)
          raise Exceptions::ServiceException, "Attribute ID is required." if attribute_id.nil?
          url = Util::Config.get('endpoints.base_url') + sprintf(Util::Config.get('endpoints.crud_attribute'), attribute_id)
          url = build_url(url)
          response = RestClient.delete(url, get_headers())
          response.code == 204
        end
      end
    end
  end
end