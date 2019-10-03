require "ostruct"

module Proxin
  class Conclusion
    attr_reader :status, :groups

    def initialize
      initialize_groups
    end

    def handle_tasks_output(tasks)
      build_groups(tasks)
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

    def build_groups(tasks)
      group_tasks_by_proxies(tasks).each do |_proxy_string, grouped_task|
        if grouped_task[:failed_tasks].count == 0
          @groups.alive << grouped_task
        elsif grouped_task[:successful_tasks].count > 0
          @groups.sick << grouped_task
        else
          @groups.dead << grouped_task
        end
      end
    end

    def group_tasks_by_proxies(tasks)
      grouped_tasks = {}

      tasks.each do |task|
        if grouped_tasks[task[:proxy].to_s].nil?
          grouped_tasks[task[:proxy].to_s] = {
              proxy: task[:proxy],
              successful_tasks: [],
              failed_tasks: []
          }
        end

        if task[:output].status == ImplementerStatusType::SUCCESS
          grouped_tasks[task[:proxy].to_s][:successful_tasks] << task
        else
          grouped_tasks[task[:proxy].to_s][:failed_tasks] << task
        end
      end

      grouped_tasks
    end

    def update_status_by_groups
      if @groups.sick.empty? && @groups.dead.empty?
        return @status = ConclusionStatusType::SUCCESS
      elsif @groups.alive.empty? && @groups.sick.empty?
        return @status = ConclusionStatusType::FAILURE
      end

      @status = ConclusionStatusType::PARTIAL_SUCCESS
    end

    def initialize_groups
      @groups = OpenStruct.new(alive: [], sick: [], dead: [])
    end
  end
end
