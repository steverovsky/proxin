module Proxin
  class ActionType
    HTTP_GETTER = "http_getter".freeze

    def self.all
      [HTTP_GETTER]
    end
  end
end
