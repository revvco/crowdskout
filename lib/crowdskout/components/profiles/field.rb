#
# field.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Field < Component
      # value can either be a string or a hash
      attr_accessor :key_name, :value

      # Factory method to create an Field object from a json string
      # @param [String] key_name - name of the Field
      # @param [Hash or String] value - properties to create object from
      # @return [Field]
      def self.create(props)
        obj = Field.new
        props.each do |key, value|
          obj.key_name = key
          if value.is_a?(Hash)
            obj.value = Value.create(value)
          else
            obj.value = value
          end
        end
        obj
      end

      # Hash override to generate the correct hash
      def to_hash
        {
          key_name => (value.to_hash rescue value)
        }
      end
    end
  end
end