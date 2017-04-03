#
# tracking_code_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::TrackingCode do
  before do 
    @json_string = %[{
                        "source": 1,
                        "organization": 2,
                        "client": 3
                      }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a component" do
    component = Crowdskout::Components::TrackingCode.create(@hash)
    expect(component.source).to eq 1
    expect(component.organization).to eq 2
    expect(component.client).to eq 3
    
    expect(component.tracking_code_source.gsub(/\s+/, " ")).to eq           %{
            <!-- Crowdskout -->
            <script>
              (function(s,k,o,u,t){
                s.cs=s.cs||function(){cs.q.push(arguments);};
                cs.q=cs.q||[];cs.apiUrl=t;
                s.sourceId = #{component.source};s.clientId = #{component.client};s.organizationId = #{component.organization};
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
            }.gsub(/\s+/, " ")
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::TrackingCode.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end