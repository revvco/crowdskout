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
            obj.send("#{key}=", value) if obj.respond_to? key
          end
        end
        obj
      end
    end
  end
end