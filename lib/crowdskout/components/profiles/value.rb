#
# value.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Value < Component
      attr_accessor :id, :value

      # Factory method to create an Value object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Value]
      def self.create(props)
        obj = Value.new
        if props
          props.each do |key, value|
            if obj.respond_to? key
              obj.send("#{key}=", value) 
            else
              # this will create the attribute if it doesn't exist
              obj.class.send(:attr_accessor, key)
              obj.instance_variable_set("@#{key}", value)
            end
          end
        end
        obj
      end
    end
  end
end