#
# profile.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class Profile < Component
      attr_accessor :id, :names, :genders

      # Factory method to create an Profile object from a json string
      # @param [Hash] props - properties to create object from
      # @return [Profile]
      def self.create(props)
        obj = Profile.new
        if props
          props.each do |key, value|
            if key.downcase == 'names'
              if value
                obj.names = []
                value.each do |name|
                  obj.names << Components::Name.create(name)
                end
              end
            elsif key.downcase == 'genders'
              if value
                obj.genders = []
                value.each do |gender|
                  obj.genders << Components::Gender.create(gender)
                end
              end
            else
              obj.send("#{key}=", value) if obj.respond_to? key
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

    end
  end
end