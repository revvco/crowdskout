#
# result_set.rb
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Crowdskout
  module Components
    class ResultSet
      attr_accessor :results, :next
      def initialize(results, meta)
        @results = results
      end
    end
  end
end