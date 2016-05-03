#
# field_service_spec.rb
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Services::FieldService do
  before(:each) do
    @request = double('http request', :user => nil, :password => nil, :url => 'http://example.com', :redirection_history => nil)
  end

  describe "#get_options_for_a_field" do
    it "returns a field" do
      json = load_file('field_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:get).and_return(response)
      field = Crowdskout::Services::FieldService.get_options_for_a_field("AddressCity")

      field.should be_kind_of(Crowdskout::Components::FieldOptions)
      field.collection.should eq "PhysicalAddresses"
      field.options[0].value.should eq "Lisbon"
    end
  end
end