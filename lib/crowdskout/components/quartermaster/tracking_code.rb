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
          %{
            <!-- Crowdskout -->
            <script>
              (function(s,k,o,u,t){
                s.cs=s.cs||function(){cs.q.push(arguments);};
                cs.q=cs.q||[];cs.apiUrl=t;s.sourceId=6041;s.clientId=1637;s.organizationId=142092;
                var a=k.getElementsByTagName(o)[0];var b=k.createElement(o);b.src=u+'/analytics.js';
                b.onreadystatechange = b.onload = function() {
                  if ((!b.readyState || /loaded|complete/.test(b.readyState))) {
                    s._csCalledBackup = s._csCalled;
                    s._csCalled = function(type, body) {
                      if (type === 'page-view') {
                        s.cspageviewuuid = body.uuid;
                      }
                      if (s._csCalledBackup) {
                        s._csCalledBackup(type, body);
                      }
                    };
                  }
                };
                a.parentNode.insertBefore(b,a);
              })(window,document,'script','//s.crowdskout.com','https://a.crowdskout.com');
              </script>
            }
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