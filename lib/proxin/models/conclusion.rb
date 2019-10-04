require "ostruct"

module Proxin
  class Conclusion
    attr_reader :status, :groups, :proxies

    def initialize
      initialize_groups
      initialize_proxies
    end

    def handle_tasks_output(tasks)
      build_reports(tasks)
      build_groups
      update_status_by_groups
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

    private

    def build_reports(tasks)
      @proxies = []
      group_tasks_by_proxies(tasks).each do |_proxy_string, grouped_task|
        proxy = grouped_task[:proxy]
        proxy.write_reports(grouped_task[:reports])

        @proxies << proxy
      end
    end

    def build_groups
      @proxies.each do |proxy|
        if proxy.reports(report_statuses: [ImplementerStatusType::FAILURE]).count == 0
          @groups.alive << proxy
        elsif proxy.reports(report_statuses: [ImplementerStatusType::SUCCESS]).count > 0
          @groups.sick << proxy
        else
          @groups.dead << proxy
        end
      end
    end

    def group_tasks_by_proxies(tasks)
      grouped_tasks = {}

      tasks.each do |task|
        grouped_tasks[task[:proxy].to_s] ||= { proxy: task[:proxy], reports: [] }
        grouped_tasks[task[:proxy].to_s][:reports] << ProxyReport.new(action: task[:action], output: task[:output])
      end

      grouped_tasks
    end

    def update_status_by_groups
      @status =
        if @groups.sick.empty? && @groups.dead.empty?
          ConclusionStatusType::SUCCESS
        elsif @groups.alive.empty? && @groups.sick.empty?
          ConclusionStatusType::FAILURE
        else
          ConclusionStatusType::PARTIAL_SUCCESS
        end
    end

    def initialize_groups
      @groups = OpenStruct.new(alive: [], sick: [], dead: [])
    end

    def initialize_proxies
      @proxies = []
    end
  end
end
