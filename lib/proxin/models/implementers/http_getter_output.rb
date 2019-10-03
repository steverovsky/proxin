module Proxin
  module Implementers
    class HTTPGetterOutput
      attr_reader :uri, :status, :response_code

      def initialize(uri:, status:, response_code:)
        @uri = uri
        @status = status
        @response_code = response_code
      end
    end
  end
end
