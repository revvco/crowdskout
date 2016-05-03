# Copyright (c) 2016 Kyle Schutt. All rights reserved.require 

module Crowdskout
  module Components
    class Name < Component
      attr_accessor :id, :FullName, :NameTitle, :FirstName, :MiddleName, :LastName, :NameSuffix

      # Factory method to create an Address object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Address]
      def self.create(props)
        obj = Name.new
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