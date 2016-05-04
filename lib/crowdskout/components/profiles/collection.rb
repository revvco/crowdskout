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
      def self.create(key_name, items)
        obj = Collection.new
        obj.key_name = key_name
        obj.items = []
        if items
          items.each do |item|
            # item is a hash of fields
            obj.items << Components::Item.create(item)
          end
        end
        obj
      end
    end
  end
end