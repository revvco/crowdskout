#
# item.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Item < Component
      attr_accessor :id, :fields, :delete

      # Factory method to create an Item object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Item]
      def self.create(props)
        obj = Item.new
        obj.id = 0
        obj.fields = []
        if props
          props.each do |key, value|
            if ['id'].include? key.downcase
              obj.send("#{key}=", value) if obj.respond_to? key
            else
              # key is the name of the field
              # value is the field's value
              obj.fields << Components::Field.create(key, value)
            end
          end
        end
        obj
      end
    end
  end
end