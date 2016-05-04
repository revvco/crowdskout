#
# result_set.rb
# Crowdskout
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class ResultSet
      attr_accessor :results, :messages
      def initialize(results, messages)
        @results = results
        @messages = messages
      end
    end
  end
end