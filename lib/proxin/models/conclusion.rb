module Proxin
  class Conclusion
    attr_reader :status
    # TODO: нельзя писать в статистику

    def proxies
      @proxies ||= []
    end

    def statistics
      raise NotImplementedError
    end

    def groups
      raise NotImplementedError
    end

    def success?
      @status == Proxin::ConclusionStatusType::SUCCESS
    end

    def partial_success?
      @status == Proxin::ConclusionStatusType::PARTIAL_SUCCESS
    end

    def failure?
      @status == Proxin::ConclusionStatusType::FAILURE
    end
  end
end
