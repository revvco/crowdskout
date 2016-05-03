module Crowdskout
  module Services
    class ProfileService < BaseService
      class << self
        # more info - http://docs.crowdskout.com/api/#get-a-profile-by-id
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
        def create_profile(profile, params = {})
          raise Exceptions::ServiceException, "Profile object must not be nil." if profile.nil?
          url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.profile')
          url = build_url(url, params)
          payload = profile.to_json
          response = RestClient.post(url, payload, get_headers())
          Components::Profile.create(JSON.parse(response.body)["data"])
        end

        # more info - http://docs.crowdskout.com/api/#create-many-profiles
        def create_profiles_bulk(profiles)
          raise Exceptions::ServiceException, "Must be an array of profiles." if profiles.nil? || !profiles.is_a?(Array)
          url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.profile_bulk')
          url = build_url(url)
          payload = profiles.to_json
          response = RestClient.post(url, payload, get_headers())
          body = JSON.parse(response.body)

          profiles = []
          body['data'].each do |profile|
            profiles << Components::Profile.create(profile)
          end if body['data'].count > 0

          Components::ResultSet.new(profiles, body['messages'])
        end

        # more info - http://docs.crowdskout.com/api/#update-a-profile-by-id
        def update_profile(profile)
          raise Exceptions::ServiceException, "Profile object must not be nil." if profile.nil?
          url = Util::Config.get('endpoints.base_url') + sprintf(Util::Config.get('endpoints.crud_profile'), profile.id)
          url = build_url(url)
          payload = profile.to_json
          response = RestClient.put(url, payload, get_headers())
          Components::Profile.create(JSON.parse(response.body)["data"])
        end

        # more info - http://docs.crowdskout.com/api/#update-many-profiles
        def update_profiles_bulk(profiles)
          raise Exceptions::ServiceException, "Must be an array of profiles." if profiles.nil? || !profiles.is_a?(Array)
          url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.profile_bulk')
          url = build_url(url)
          payload = profiles.to_json
          response = RestClient.put(url, payload, get_headers())
          body = JSON.parse(response.body)

          profiles = []
          body['data'].each do |profile|
            profiles << Components::Profile.create(profile)
          end if body['data'].count > 0

          Components::ResultSet.new(profiles, body['messages'])
        end
      end
    end
  end
end