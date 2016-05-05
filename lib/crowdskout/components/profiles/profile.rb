#
# profile.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Profile < Component
      attr_accessor :id, :collections

      # Factory method to create an Profile object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Profile]
      def self.create(props)
        obj = Profile.new
        obj.collections = []
        if props
          props.each do |key, value|
            if ['id'].include? key.downcase
              obj.send("#{key}=", value) if obj.respond_to? key
            else
              # the key is the name of the collection
              # the value is an array of items
              obj.collections << Components::Collection.create({key => value})
            end
          end
        end
        obj
      end

      # Add a Name
      # @param [Name] name
      # @return [Array] the names array
      def add_names(name)
        @names = [] if @names.nil?
        @names << name
      end

      # Add a Gender
      # @param [Gebder] gender
      # @return [Array] the genders array
      def add_genders(gender)
        @genders = [] if @genders.nil?
        @genders << gender
      end

      # Hash override to generate the correct hash
      def to_hash
        ret_val = { id: id }
        collections.each do |collection|
          ret_val.merge! collection.to_hash
        end
        ret_val
      end

    end
  end
end