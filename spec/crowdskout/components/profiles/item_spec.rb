#
# item_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::Item do
  before do 
    @json_string = %[{
                        "id" : 1,
                        "Gender" : {
                          "id" : 1,
                          "value" : "Male"
                        },
                        "TestValue" : "value"
                      }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a component" do
    component = Crowdskout::Components::Item.create(@hash)
    expect(component.id).to eq 1
    component.fields[0].should be_kind_of(Crowdskout::Components::Field)
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::Item.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end