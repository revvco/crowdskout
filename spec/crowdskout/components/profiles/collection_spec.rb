#
# collection_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::Collection do
  before do 
    @json_string = %[{
                        "Names" : [
                            {
                              "id" : 1,
                              "FullName" : "Mr. Ferdinand Magellan",
                              "NameTitle" : "Mr.",
                              "FirstName" : "Ferdinand",
                              "MiddleName" : "",
                              "LastName" : "Magellan",
                              "NameSuffix" : "",
                              "Gender" : {
                                "id" : 1,
                                "value" : "Male"
                              }
                            }
                          ]
                      }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a component" do
    component = Crowdskout::Components::Collection.create(@hash)
    expect(component.key_name).to eq "Names"
    expect(component.items.count).to eq 1
    component.items[0].should be_kind_of(Crowdskout::Components::Item)
    expect(component.items[0].fields.count).to eq 7
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::Collection.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end