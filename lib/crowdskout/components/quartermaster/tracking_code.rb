#
# tracking_code.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class TrackingCode < Component
      attr_accessor :source, :organization, :client

      # Factory method to create a TrackingCode object from a json string
      # @param [Hash] props - properties to create object from
      # @return [TrackingCode]
      def self.create(props)
        obj = TrackingCode.new
        if props
          props.each do |key, value|
            obj.send("#{key}=", value.to_i) if obj.respond_to? key
          end
        end
        obj
      end

      # Generate the crowdskout tracking source based on the codes
      # @return [String] javascript function with the tracking information
      def tracking_code_source
        if !source.nil? && !organization.nil? && !client.nil?
          %{<!-- Crowdskout -->
            <script>
            (function(l,o,v,e,d) {
              l.cs=l.cs || function() {cs.q.push(arguments);};
              cs.q=cs.q||[];cs.apiUrl=d;cs('pageView');
              l.sourceId = #{source};l.clientId = #{client};l.organizationId = #{organization};
              var a=o.getElementsByTagName(v)[0];var b=o.createElement(v);b.src=e+'/analytics.js';a.parentNode.insertBefore(b,a);
              })(window, document, 'script', '//s.crowdskout.com','https://a.crowdskout.com');
              </script>}
            else
              %{
                Tracking Codes Error
                Source: #{source}
                Organization: #{organization}
                Client: #{client}
              }
            end
          end
        end
      end
    end