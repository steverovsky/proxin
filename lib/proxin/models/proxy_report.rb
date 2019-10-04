module Proxin
  class ProxyReport
    attr_reader :action, :output

    def initialize(action:, output:)
      @action = action
      @output = output
    end

    def ==(object)
      object.class == self.class && object.action == action && object.output == output
    end
  end
end
