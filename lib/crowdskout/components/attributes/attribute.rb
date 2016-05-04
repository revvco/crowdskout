#
# attribute.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Attribute < Component
      attr_accessor :id, :type, :locked, :name, :options

      # Factory method to create an Attribute object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Attribute]
      def self.create(props)
        obj = Attribute.new
        if props
          props.each do |key, value|
            if key.downcase == 'options'
              if value
                obj.options = []
                value.each do |option|
                  obj.options << Components::Option.create(option)
                end
              end
            else
              obj.send("#{key}=", value) if obj.respond_to? key
            end
          end
        end
        obj
      end

      # Add an Option
      # @param [Option] option
      # @return [Array] the options array
      def add_options(option)
        @options = [] if @options.nil?
        @options << option
      end
    end
  end
end