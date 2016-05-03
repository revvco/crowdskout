module Crowdskout
  module Components
    class FieldOptions < Component
      attr_accessor :id, :collection, :options

      def self.create(props)
        obj = FieldOptions.new
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

      def add_options(option)
        @options = [] if @options.nil?
        @options << option
      end
    end
  end
end