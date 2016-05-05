#
# profile_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::Profile do
  before do 
    @json_string = %[{
                      "id" : 1,
                      "Names" : [
                        {
                          "id" : 1,
                          "FullName" : "Mr. Ferdinand Magellan",
                          "NameTitle" : "Mr.",
                          "FirstName" : "Ferdinand",
                          "MiddleName" : "",
                          "LastName" : "Magellan",
                          "NameSuffix" : ""
                        }
                      ],
                      "Genders" : [
                        {
                          "id" : 1,
                          "Gender" : {
                            "id" : 1,
                            "value" : "Male"
                          },
                          "TestValue" : "value"
                        }
                      ]
                    }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a component" do
    component = Crowdskout::Components::Profile.create(@hash)
    expect(component.id).to eq 1
    expect(component.collections.count).to eq 2
    component.collections[0].should be_kind_of(Crowdskout::Components::Collection)
    expect(component.collections[0].items.count).to eq 1
    component.collections[0].items[0].should be_kind_of(Crowdskout::Components::Item)
    
    expect(component.collections[0].items[0].fields.count).to eq 6
    component.collections[0].items[0].fields[0].should be_kind_of(Crowdskout::Components::Field)
    
    expect(component.collections[0].items[0].fields[0].value).to eq "Mr. Ferdinand Magellan"
  end
  it "generates the correct json object" do 
    component = Crowdskout::Components::Profile.create(@hash)
    expect(JSON.parse(component.to_json)).to eq @hash
  end
end