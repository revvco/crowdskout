#
# profile_service_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Services::ProfileService do
  before(:each) do
    @request = double('http request', :user => nil, :password => nil, :url => 'http://example.com', :redirection_history => nil)
  end

  describe "#get_profile" do
    it "returns a profile" do
      json = load_file('profile_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:get).and_return(response)
      profile = Crowdskout::Services::ProfileService.get_profile(1, "Names,Genders")

      profile.should be_kind_of(Crowdskout::Components::Profile)
      profile.collections[1].should be_kind_of(Crowdskout::Components::Collection)
      profile.collections[1].key_name.should eq 'Genders'
      profile.collections[1].items[0].should be_kind_of(Crowdskout::Components::Item)
      profile.collections[1].items[0].id.should eq 1
      profile.collections[1].items[0].fields[0].should be_kind_of(Crowdskout::Components::Field)
      profile.collections[1].items[0].fields[0].key_name.should eq "Gender"
      profile.collections[1].items[0].fields[0].value.should be_kind_of(Crowdskout::Components::Value)
      profile.collections[1].items[0].fields[0].value.id.should eq 1
      profile.collections[1].items[0].fields[0].value.value.should eq "Male"
      profile.collections[1].items[0].fields[1].key_name.should eq "TestValue"
      profile.collections[1].items[0].fields[1].value.should eq "value"
    end
  end

  describe "#create_profile" do
    it "adds a profile" do
      json = load_file('profile_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:post).and_return(response)
      new_profile = Crowdskout::Components::Profile.create(JSON.parse(json)["data"])
      profile = Crowdskout::Services::ProfileService.create_profile(new_profile)

      profile.should be_kind_of(Crowdskout::Components::Profile)
      profile.collections[1].should be_kind_of(Crowdskout::Components::Collection)
      profile.collections[1].key_name.should eq 'Genders'
      profile.collections[1].items[0].should be_kind_of(Crowdskout::Components::Item)
      profile.collections[1].items[0].id.should eq 1
      profile.collections[1].items[0].fields[0].should be_kind_of(Crowdskout::Components::Field)
      profile.collections[1].items[0].fields[0].key_name.should eq "Gender"
      profile.collections[1].items[0].fields[0].value.should be_kind_of(Crowdskout::Components::Value)
      profile.collections[1].items[0].fields[0].value.id.should eq 1
      profile.collections[1].items[0].fields[0].value.value.should eq "Male"
      profile.collections[1].items[0].fields[1].key_name.should eq "TestValue"
      profile.collections[1].items[0].fields[1].value.should eq "value"
    end
  end

  describe "#create_profiles_bulk" do
    it "adds a profile" do
      json = load_file('profile_bulk_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:post).and_return(response)
      profiles = []
      body = JSON.parse(json)
      body['data'].each do |profile|
        profiles << Crowdskout::Components::Profile.create(profile)
      end if body['data'].count > 0
      profiles = Crowdskout::Services::ProfileService.create_profiles_bulk(profiles)
      profile = profiles.results[0]

      profiles.should be_kind_of(Crowdskout::Components::ResultSet)
      profile.should be_kind_of(Crowdskout::Components::Profile)
      profile.collections[0].should be_kind_of(Crowdskout::Components::Collection)
      profile.collections[0].key_name.should eq 'Genders'
      profile.collections[0].items[0].should be_kind_of(Crowdskout::Components::Item)
      profile.collections[0].items[0].id.should eq 1
      profile.collections[0].items[0].fields[0].should be_kind_of(Crowdskout::Components::Field)
      profile.collections[0].items[0].fields[0].key_name.should eq "Gender"
      profile.collections[0].items[0].fields[0].value.should be_kind_of(Crowdskout::Components::Value)
      profile.collections[0].items[0].fields[0].value.id.should eq 1
      profile.collections[0].items[0].fields[0].value.value.should eq "Male"
    end
  end

  describe "#update_profile" do
    it "updates a profile" do
      json = load_file('profile_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:put).and_return(response)
      profile = Crowdskout::Components::Profile.create(JSON.parse(json)["data"])
      result = Crowdskout::Services::ProfileService.update_profile(profile)

      result.should be_kind_of(Crowdskout::Components::Profile)
      result.collections[1].should be_kind_of(Crowdskout::Components::Collection)
      result.collections[1].key_name.should eq 'Genders'
      result.collections[1].items[0].should be_kind_of(Crowdskout::Components::Item)
      result.collections[1].items[0].id.should eq 1
      result.collections[1].items[0].fields[0].should be_kind_of(Crowdskout::Components::Field)
      result.collections[1].items[0].fields[0].key_name.should eq "Gender"
      result.collections[1].items[0].fields[0].value.should be_kind_of(Crowdskout::Components::Value)
      result.collections[1].items[0].fields[0].value.id.should eq 1
      result.collections[1].items[0].fields[0].value.value.should eq "Male"
      result.collections[1].items[0].fields[1].key_name.should eq "TestValue"
      result.collections[1].items[0].fields[1].value.should eq "value"
    end
  end

  describe "#update_profiles_bulk" do
    it "adds a profile" do
      json = load_file('profile_bulk_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:put).and_return(response)
      profiles = []
      body = JSON.parse(json)
      body['data'].each do |profile|
        profiles << Crowdskout::Components::Profile.create(profile)
      end if body['data'].count > 0
      profiles = Crowdskout::Services::ProfileService.update_profiles_bulk(profiles)
      profile = profiles.results[0]

      profiles.should be_kind_of(Crowdskout::Components::ResultSet)
      profile.collections[0].should be_kind_of(Crowdskout::Components::Collection)
      profile.collections[0].key_name.should eq 'Genders'
      profile.collections[0].items[0].should be_kind_of(Crowdskout::Components::Item)
      profile.collections[0].items[0].id.should eq 1
      profile.collections[0].items[0].fields[0].should be_kind_of(Crowdskout::Components::Field)
      profile.collections[0].items[0].fields[0].key_name.should eq "Gender"
      profile.collections[0].items[0].fields[0].value.should be_kind_of(Crowdskout::Components::Value)
      profile.collections[0].items[0].fields[0].value.id.should eq 1
      profile.collections[0].items[0].fields[0].value.value.should eq "Male"
    end
  end
end