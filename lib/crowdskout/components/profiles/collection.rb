#
# collection.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Collection < Component
      attr_accessor :key_name, :items

      # Factory method to create an Collection object from a json string
      # @param [String] key_name - name of the collection
      # @param [Array] items - properties to create object from
      # @return [Collection]
      def self.create(props)
        obj = Collection.new
        obj.items = []
        props.each do |key, value|
          obj.key_name = key
          if value.is_a?(Hash) || value.is_a?(Array)
            value.each do |collection|
              obj.items << Components::Item.create(collection)
            end
          else
            obj.items << Components::Item.create({ key => value })
          end
        end
        obj
      end

      # Hash override to generate the correct hash
      def to_hash
        {
          key_name => items.collect(&:to_hash)
        }
      end
    end
  end
end