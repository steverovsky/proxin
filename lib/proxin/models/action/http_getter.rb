module Proxin
  module Action
    class HTTPGetter
      attr_reader :uri

      def initialize(uri:)
        @uri = uri
      end
    end
  end
end
