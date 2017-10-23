#
# attribute_service.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Services
    class AttributeService < BaseService

      # More info - http://docs.crowdskout.com/api/#get-all-attributes
      # @param [Hash] params - query parameters
      # @return [ResultSet] set of Components::Attributes
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
      # @param [Integer] attribute_id - the id of the attribute to fetch
      # @param [Hash] params - query parameters
      # @return [Attribute]
      def get_attribute(attribute_id, params = {})
        raise Exceptions::ServiceException, "Attribute ID is required." if attribute_id.nil?
        url = Util::Config.get('endpoints.base_url') +
              sprintf(Util::Config.get('endpoints.crud_attribute'), attribute_id)
        url = build_url(url, params)
        response = RestClient.get(url, get_headers())
        Components::Attribute.create(JSON.parse(response.body)["data"])
      end

      # more info - http://docs.crowdskout.com/api/#create-an-attribute
      # @param [Attribute] attribute - attribute object to add to Crowdskout
      # @return [Attribute]
      def create_attribute(new_attribute)
        raise Exceptions::ServiceException, "Attribute must not be nil" if new_attribute.nil?
        url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.attribute')
        url = build_url(url)
        payload = new_attribute.to_json
        response = RestClient.post(url, payload, get_headers())
        Components::Attribute.create(JSON.parse(response.body)["data"])
      end

      # more info - http://docs.crowdskout.com/api/#update-an-attribute
      # @param [Integer] attribute_id - the id of the attribute to update
      # @param [Hash] params - query parameters
      # @return [Attribute]
      def update_attribute(attribute_id, params = {})
        raise Exceptions::ServiceException, "Attribute ID is required." if attribute_id.nil?
        url = Util::Config.get('endpoints.base_url') + sprintf(Util::Config.get('endpoints.crud_attribute'), attribute_id)
        url = build_url(url)
        response = RestClient.put(url, params, get_headers())
        Components::Attribute.create(JSON.parse(response.body)["data"])
      end

      # more info - http://docs.crowdskout.com/api/#delete-an-attribute
      # @param [Integer] attribute_id - the id of the attribute to update
      # @return [boolean]
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
