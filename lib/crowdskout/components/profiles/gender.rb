#
# gender.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Gender < Component
      attr_accessor :id, :gender

      # Factory method to create an Gender object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Gender]
      def self.create(props)
        obj = Gender.new
        if props
          props.each do |key, value|
            if key.downcase == 'gender'
              obj.gender = GenderInfo.create(value)
            else
              obj.send("#{key}=", value) if obj.respond_to? key
            end
          end
        end
        obj
      end
    end
    
    # Detailed gender information
    class GenderInfo
      attr_accessor :id, :value

      # Factory method to create an GenderInfo object from a json string
      # @param [Hash] props - properties to create object from
      # @return [GenderInfo]
      def self.create(props)
        obj = GenderInfo.new
        if props
          props.each do |key, value|
            obj.send("#{key}=", value) if obj.respond_to? key
          end
        end
        obj
      end
    end
  end
end