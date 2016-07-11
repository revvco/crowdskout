#
# quartermaster_service.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Services
    class QuartermasterService < BaseService
      class << self

        # More info - to get the tracking codes for CrowdSkout
        # @return [Components::TrackingCode] Components::TrackingCode
        def tracking_code
          url = Util::Config.get('endpoints.base_url') + Util::Config.get('endpoints.attributes')

          response = RestClient.get(url, get_headers())
          Components::TrackingCode.create(JSON.parse(response.body)["data"])
        end
      end
    end
  end
end