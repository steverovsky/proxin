module Proxin
  class Boiler
    attr_reader :actions, :proxies, :tasks, :conclusion

    def initialize(proxies, actions)
      @proxies = proxies
      @actions = actions
    end

    def call
      initialize_conclusion
      build_tasks
      process_tasks
      handle_tasks_output
    end

    private

    def initialize_conclusion
      @conclusion ||= Conclusion.new
    end

    def build_tasks
      @tasks = []

      @actions.each do |action|
        @proxies.each do |proxy|
          @tasks << { action: action, proxy: proxy }
        end
      end
    end

    def process_tasks
      @tasks.each do |task|
        executor = find_task_executor(task).new(proxy: task[:proxy], action: task[:action])
        executor.call

        task.merge!(output: executor.output)
      end
    end

    def handle_tasks_output
      @conclusion.handle_tasks_output(@tasks)
    end

    def find_task_executor(task)
      case task[:action]
      when Action::HTTPGetter then Implementers::HTTPGetter
      else raise NotImplementedError
      end
    end
  end
end
