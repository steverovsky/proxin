require 'forwardable'

module Proxin
  class Boiler
    extend Forwardable

    def_delegators :@conclusion,
                   :statistics, :groups, :status, :success?, :partial_success?, :failure

    attr_reader :proxies,
                :actions,
                :conclusion

    def initialize(proxies, actions: ActionType.all)
      initialize_components(proxies, expected_class: Proxy, attribute_name: :proxies)
      initialize_components(actions, expected_class: Action::Base, attribute_name: :actions)
    end

    def run
      initialize_conclusion
      perform_actions
      summarize_conclusion
    end

    private

    def initialize_conclusion
      raise NotImplementedError
    end

    def perform_actions # TODO: метод построить пары и пройтись по ним
      @proxies.each do |proxy|
        @actions.each do |action|
          @conclusion.handle_action_output(perform_action(proxy, action))
          # TODO: Conclusion::ActionHandler.new(conclusion, performer_output)
          # TODO: Conclusion::ActionHandlers::HTTPGetter
          # этот сервис должен
          # добавить в секцию details запись
          # найти прокси по proxy.to_s
        end
      end
    end

    def perform_action(proxy, action)
      implementer = Implementer.new(proxy: proxy, action: action)
      implementer.call

      implementer.output
    end

    def summarize_conclusion
      # TODO: считает секцию
      # посчитать status
      # посчитать statistics
      # посчитать groups

      @conclusion.summarize
    end

    def initialize_components(component, expected_class:, attribute_name:)
      validate_component(component, expected_class: expected_class)

      instance_variable_set(
        "@#{attribute_name.to_s}",
        component.is_a?(Array) ? component : [component]
      )
    end

    def validate_component(component, expected_class:)
      if !component.is_a?(expected_class) || (component.is_a?(Array) && component.empty?)
        # TODO: проверить объекты внутри массива
        raise Proxin::InvalidComponentError
      end
    end
  end
end
