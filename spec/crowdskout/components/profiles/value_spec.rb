#
# value_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::Value do
  before do 
    @json_string = %[{
                        "id" : 1,
                        "value" : "Male"
                      }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a component" do
    component = Crowdskout::Components::Value.create(@hash)
    expect(component.id).to eq 1
    expect(component.value).to eq "Male"
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::Value.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end