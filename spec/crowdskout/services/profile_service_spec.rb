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
      profile.names[0].should be_kind_of(Crowdskout::Components::Name)
      profile.names[0].FullName.should eq 'Mr. Ferdinand Magellan'
      profile.genders[0].should be_kind_of(Crowdskout::Components::Gender)
      profile.genders[0].gender.should be_kind_of(Crowdskout::Components::GenderInfo)
      profile.genders[0].gender.value.should eq 'Male'
    end
  end

  describe "#create_profile" do
    it "adds a profile" do
      json = load_file('profile_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:post).and_return(response)
      new_profile = Crowdskout::Components::Profile.create(JSON.parse(json))
      profile = Crowdskout::Services::ProfileService.create_profile(new_profile)

      profile.should be_kind_of(Crowdskout::Components::Profile)
      profile.names[0].should be_kind_of(Crowdskout::Components::Name)
      profile.names[0].FullName.should eq 'Mr. Ferdinand Magellan'
      profile.genders[0].should be_kind_of(Crowdskout::Components::Gender)
      profile.genders[0].gender.should be_kind_of(Crowdskout::Components::GenderInfo)
      profile.genders[0].gender.value.should eq 'Male'
    end
  end

  describe "#create_profiles_bulk" do
    it "adds a profile" do
      json = load_file('profile_bulk_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:post).and_return(response)
      new_profile = Crowdskout::Components::Profile.create(JSON.parse(json))
      profiles = []
      body = JSON.parse(json)
      body['data'].each do |profile|
        profiles << Crowdskout::Components::Profile.create(profile)
      end if body['data'].count > 0
      profiles = Crowdskout::Services::ProfileService.create_profiles_bulk(profiles)
      profile = profiles.results[0]

      profiles.should be_kind_of(Crowdskout::Components::ResultSet)
      profile.should be_kind_of(Crowdskout::Components::Profile)
      profile.genders[0].should be_kind_of(Crowdskout::Components::Gender)
      profile.genders[0].gender.should be_kind_of(Crowdskout::Components::GenderInfo)
      profile.genders[0].gender.value.should eq 'Male'
    end
  end

  describe "#update_profile" do
    it "updates a profile" do
      json = load_file('profile_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:put).and_return(response)
      profile = Crowdskout::Components::Profile.create(JSON.parse(json))
      result = Crowdskout::Services::ProfileService.update_profile(profile)

      result.should be_kind_of(Crowdskout::Components::Profile)
      result.names[0].should be_kind_of(Crowdskout::Components::Name)
      result.names[0].FullName.should eq 'Mr. Ferdinand Magellan'
      result.genders[0].should be_kind_of(Crowdskout::Components::Gender)
      result.genders[0].gender.should be_kind_of(Crowdskout::Components::GenderInfo)
      result.genders[0].gender.value.should eq 'Male'
    end
  end

  describe "#update_profiles_bulk" do
    it "adds a profile" do
      json = load_file('profile_bulk_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:put).and_return(response)
      new_profile = Crowdskout::Components::Profile.create(JSON.parse(json))
      profiles = []
      body = JSON.parse(json)
      body['data'].each do |profile|
        profiles << Crowdskout::Components::Profile.create(profile)
      end if body['data'].count > 0
      profiles = Crowdskout::Services::ProfileService.update_profiles_bulk(profiles)
      profile = profiles.results[0]

      profiles.should be_kind_of(Crowdskout::Components::ResultSet)
      profile.should be_kind_of(Crowdskout::Components::Profile)
      profile.genders[0].should be_kind_of(Crowdskout::Components::Gender)
      profile.genders[0].gender.should be_kind_of(Crowdskout::Components::GenderInfo)
      profile.genders[0].gender.value.should eq 'Male'
    end
  end
end