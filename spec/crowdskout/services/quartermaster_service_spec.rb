#
# quartermaster_service_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Services::QuartermasterService do
  before(:each) do
    @request = double('http request', :user => nil, :password => nil, :url => 'http://example.com', :redirection_history => nil)
  end

  describe "#tracking_code" do
    it "returns a tracking code" do
      json = load_file('tracking_code_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {}, @request)
      RestClient.stub(:get).and_return(response)
      tracking_code = Crowdskout::Services::QuartermasterService.tracking_code

      tracking_code.should be_kind_of(Crowdskout::Components::TrackingCode)

      expect(tracking_code.source).to eq 1
      expect(tracking_code.organization).to eq 2
      expect(tracking_code.client).to eq 3
      
      expect(tracking_code.tracking_code_source.gsub(/\s+/, " ")).to eq %{<!-- Crowdskout -->
        <script>
        (function(l,o,v,e,d) {
          l.cs=l.cs || function() {cs.q.push(arguments);};
          cs.q=cs.q||[];cs.apiUrl=d;cs('pageView');
          l.sourceId = #{tracking_code.source};l.clientId = #{tracking_code.client};l.organizationId = #{tracking_code.organization};
          var a=o.getElementsByTagName(v)[0];var b=o.createElement(v);b.src=e+'/analytics.js';a.parentNode.insertBefore(b,a);
          })(window, document, 'script', '//s.crowdskout.com','https://a.crowdskout.com');
          </script>}.gsub(/\s+/, " ")
        end
      end
    end