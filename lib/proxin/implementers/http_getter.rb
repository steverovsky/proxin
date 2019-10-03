require "typhoeus"

module Proxin
  module Implementers
    class HTTPGetter
      attr_reader :proxy, :action, :response, :output

      def initialize(proxy:,action:)
        @proxy = proxy
        @action = action
      end

      def call
        perform_action
        handle_response
      end

      private

      # TODO: можно ли без прокси?
      def perform_action
        request = Typhoeus::Request.new(
          @action.uri,
          method: :get,
          followlocation: true,
          proxy: "http://#{@proxy.ip}:#{@proxy.port}",
          proxyuserpwd: "#{@proxy.username}:#{@proxy.password}"
        )

        @response = request.run
      end

      def handle_response
        @output = Implementers::HTTPGetterOutput.new(
          uri: @action.uri,
          status: @response.success? ? ImplementerStatusType::SUCCESS : ImplementerStatusType::FAILURE,
          response_code: @response.code
        )
      end
    end
  end
end
