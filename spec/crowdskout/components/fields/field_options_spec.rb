#
# field_options_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::FieldOptions do
  before do 
    @json_string = %[{
                        "collection" : "PhysicalAddresses",
                        "options" : [
                            {
                              "id" : 1,
                              "value" : "Lisbon"
                            }
                          ]
                      }]
    @hash = JSON.parse(@json_string)
  end

  it "creates a field option" do
    field_option = Crowdskout::Components::FieldOptions.create(@hash)
    expect(field_option.collection).to eq "PhysicalAddresses"
    expect(field_option.options.count).to eq 1
  end
  it "generates the correct json object" do 
    field_option = Crowdskout::Components::FieldOptions.create(@hash)
    expect(JSON.parse(field_option.to_json)).to eq @hash
  end
end