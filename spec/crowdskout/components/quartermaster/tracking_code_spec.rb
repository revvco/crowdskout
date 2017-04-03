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
    
    expect(component.tracking_code_source.gsub(/\s+/, " ")).to eq %{<!-- Crowdskout -->
            <script>
            (function(l,o,v,e,d) {
              l.cs=l.cs || function() {cs.q.push(arguments);};
              cs.q=cs.q||[];cs.apiUrl=d;cs('pageView');
              l.sourceId = #{component.source};l.clientId = #{component.client};l.organizationId = #{component.organization};
              var a=o.getElementsByTagName(v)[0];var b=o.createElement(v);b.src=e+'/analytics.js';
              b.onreadystatechange = b.onload = function() {
                if ((!b.readyState || /loaded|complete/.test(b.readyState))) {
                  l._csCalledBackup = l._csCalled;
                  l._csCalled = function(type, body) {
                    if (type === 'pageView') {
                      l.cspageviewuuid = body.uuid;
                    }
                    if (l._csCalledBackup) {
                      l._csCalledBackup(type, body);
                    }
                  };
                }
              };
              a.parentNode.insertBefore(b,a);
              })(window, document, 'script', '//s.crowdskout.com','https://a.crowdskout.com');
              </script>}.gsub(/\s+/, " ")
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::TrackingCode.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end