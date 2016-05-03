module Crowdskout
  module Components
    class Profile < Component
      attr_accessor :id, :names, :genders

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

      def add_names(name)
        @names = [] if @names.nil?
        @names << name
      end

      def add_genders(gender)
        @genders = [] if @genders.nil?
        @genders << gender
      end

    end
  end
end