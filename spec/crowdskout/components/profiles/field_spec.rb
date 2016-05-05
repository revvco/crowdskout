#
# field_spec.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 'spec_helper'

require 'spec_helper'

describe Crowdskout::Components::Field do
  context "hash value" do 
    before do 
      @json_string = %[{
                          "Gender" : {
                              "id" : 1,
                              "value" : "Male"
                            }
                        }]
      @hash = JSON.parse(@json_string)
    end

    it "creates a component" do
      component = Crowdskout::Components::Field.create(@hash)
      expect(component.key_name).to eq "Gender"
      component.value.should be_kind_of(Crowdskout::Components::Value)
    end
    it "generates the correct json object" do 
      component = Crowdskout::Components::Field.create(@hash)
      expect(JSON.parse(component.to_json)).to eq @hash
    end
  end
  context "string value" do 
    before do 
      @json_string = %[{
                          "Gender" : "Male"
                        }]
      @hash = JSON.parse(@json_string)
    end

    it "creates a component" do
      component = Crowdskout::Components::Field.create(@hash)
      expect(component.key_name).to eq "Gender"
      expect(component.value).to eq "Male"
    end
    it "generates the correct json object" do 
      component = Crowdskout::Components::Field.create(@hash)
      expect(JSON.parse(component.to_json)).to eq @hash
    end
  end
end