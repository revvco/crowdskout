#
# attribute_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::Attribute do
  before do 
    @json_string = %[{
                       "id" : 1,
                       "name" : "Ready to set sail",
                       "type" : "Radio",
                       "locked" : false,
                       "options" : [
                           {
                             "id" : 1,
                             "value" : "Yes"
                           },
                           {
                             "id" : 2,
                             "value" : "No"
                           }
                         ]
                     }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a component" do
    component = Crowdskout::Components::Attribute.create(@hash)
    expect(component.name).to eq "Ready to set sail"
    expect(component.type).to eq "Radio"
    expect(component.locked).to eq false
    expect(component.options.count).to eq 2
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::Attribute.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end