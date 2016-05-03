#
# attribute_service_spec.rb
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Services::AttributeService do
  before(:each) do
    @request = double('http request', :user => nil, :password => nil, :url => 'http://example.com', :redirection_history => nil)
  end

  describe "#get_attributes" do
    it "returns an array of attributes" do
      json = load_file('attributes_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:get).and_return(response)
      attributes = Crowdskout::Services::AttributeService.get_attributes()
      attribute = attributes.results[0]

      attributes.should be_kind_of(Crowdskout::Components::ResultSet)
      attribute.should be_kind_of(Crowdskout::Components::Attribute)
    end
  end

  describe "#get_attribute" do
    it "returns a attribute" do
      json = load_file('attribute_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:get).and_return(response)
      attribute = Crowdskout::Services::AttributeService.get_attribute(1)

      attribute.should be_kind_of(Crowdskout::Components::Attribute)
    end
  end

  describe "#create_attribute" do
    it "adds a attribute" do
      json = load_file('attribute_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:post).and_return(response)
      new_attribute = Crowdskout::Components::Attribute.create(JSON.parse(json))
      attribute = Crowdskout::Services::AttributeService.create_attribute(new_attribute)

      attribute.should be_kind_of(Crowdskout::Components::Attribute)
      attribute.type.should eq('Radio')
    end
  end

  describe "#delete_attribute" do
    it "deletes a attribute" do
      attribute_id = 196
      net_http_resp = Net::HTTPResponse.new(1.0, 204, 'No Content')

      response = RestClient::Response.create('', net_http_resp, {}, @request)
      RestClient.stub(:delete).and_return(response)

      result = Crowdskout::Services::AttributeService.delete_attribute(attribute_id)
      result.should be true
    end
  end

  describe "#update_attribute" do
    it "updates a attribute" do
      json = load_file('attribute_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:put).and_return(response)
      attribute = Crowdskout::Components::Attribute.create(JSON.parse(json))
      result = Crowdskout::Services::AttributeService.update_attribute(attribute)

      result.should be_kind_of(Crowdskout::Components::Attribute)
      result.type.should eq('Radio')
    end
  end
end