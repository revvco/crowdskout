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
      def self.create(key_name, value)
        obj = Field.new
        obj.key_name = key_name
        if value.is_a?(Hash)
          obj.value = Value.create(value)
        else
          obj.value = value.to_s
        end
        obj
      end
    end
  end
end