#
# profile_service.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Services
    class ProfileService < BaseService
      # more info - http://docs.crowdskout.com/api/#get-a-profile-by-id
      # Get a profile based on the collections provided
      # @param [Integer] profile_id - the id of the profile
      # @param [String] collections - A csv of the requested collections
      # @return [Profile] - the profile object
      def get_profile(profile_id, collections)
        raise Exceptions::ServiceException, "Profile ID is required." if profile_id.nil?
        raise Exceptions::ServiceException, "A comma-deliminted list of collections is required." if collections.nil?
        params = {
          collections: collections
        }
        url = Util::Config.get('endpoints.base_url') +
              sprintf(Util::Config.get('endpoints.crud_profile'), profile_id)
        url = build_url(url, params)

        response = RestClient.get(url, get_headers())
        Components::Profile.create(JSON.parse(response.body)["data"])
      end

      # more info - http://docs.crowdskout.com/api/#create-a-profile
      # Create a new profile
      # @param [Profile] profile - the new profile object to add to Crowdskout
      # @param [Hash] params - A hash with query parameters
      # @return [Profile] - the profile object
      def create_profile(profile)
        raise Exceptions::ServiceException, "Profile object must not be nil." if profile.nil?
        url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.profile')
        url = build_url(url)
        payload = {
          profile: profile.to_hash
        }.to_json
        response = RestClient.post(url, payload, get_headers())
        Components::Profile.create(JSON.parse(response.body)["data"])
      end

      # more info - http://docs.crowdskout.com/api/#create-many-profiles
      # Create a bunch of new profiles
      # @param [Array<Profile>] profiles - an array of profile to bulk add
      # @param [Hash] params - A hash with query parameters
      # @return [ResultSet] - the results set as an enumeration with profiles
      def create_profiles_bulk(profiles)
        raise Exceptions::ServiceException, "Must be an array of profiles." if profiles.nil? || !profiles.is_a?(Array)
        url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.profile_bulk')
        url = build_url(url)
        payload = {
          profiles: profiles.collect(&:to_hash)
        }.to_json
        response = RestClient.post(url, payload, get_headers())
        body = JSON.parse(response.body)

        profiles = []
        body['data'].each do |profile|
          profiles << Components::Profile.create(profile)
        end if body['data'].count > 0

        Components::ResultSet.new(profiles, body['messages'])
      end

      # more info - http://docs.crowdskout.com/api/#update-a-profile-by-id
      # Update the given profile
      # @param [Profile] profile - the profile to update
      # @return [Profile] - the profile object
      def update_profile(profile)
        raise Exceptions::ServiceException, "Profile object must not be nil." if profile.nil?
        url = Util::Config.get('endpoints.base_url') + sprintf(Util::Config.get('endpoints.crud_profile'), profile.id)
        url = build_url(url)
        payload = {
          profile: profile.to_hash
        }.to_json
        response = RestClient.put(url, payload, get_headers())
        Components::Profile.create(JSON.parse(response.body)["data"])
      end

      # more info - http://docs.crowdskout.com/api/#update-many-profiles
      # Update a bunch of profiles
      # @param [Array<Profile>] profiles - an array of profile to bulk add
      # @return [ResultSet] - the results set as an enumeration with profiles
      def update_profiles_bulk(profiles)
        raise Exceptions::ServiceException, "Must be an array of profiles." if profiles.nil? || !profiles.is_a?(Array)
        url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.profile_bulk')
        url = build_url(url)
        payload = {
          profiles: profiles.collect(&:to_hash)
        }.to_json
        response = RestClient.put(url, payload, get_headers())
        body = JSON.parse(response.body)

        profiles = []
        body['data'].each do |profile|
          profiles << Components::Profile.create(profile)
        end if body['data'].count > 0

        Components::ResultSet.new(profiles, body['messages'])
      end

      # more info - https://docs.crowdskout.com/api/#check-for-a-non-match
      #
      # Check for a non-match. The endpoints returns true if the given Profile object is definitely NOT a match.
      # That means that the ID given in the Profile object does not match the Profile data.
      #
      # @param [Profile] profile - profile to check for non-match
      # @return [boolean] - returns true if it is a non-match, false in all other scenarios
      def check_for_non_match(profile)
        raise Exceptions::ServiceException, "Profile object must not be nil." if profile.nil?
        url = Util::Config.get('endpoints.base_url') + sprintf(Util::Config.get('endpoints.check_for_non_match'), profile.id)
        url = build_url(url)
        payload = {
          profile: profile.to_hash
        }.to_json
        response = RestClient.post(url, payload, get_headers())
        JSON.parse(response.body)["data"]
      end
    end
  end
end
