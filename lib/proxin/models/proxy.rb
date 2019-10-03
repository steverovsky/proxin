module Proxin
  class Proxy
    attr_accessor :ip,
                  :port,
                  :username,
                  :password

    def to_s
      "#{@ip}:#{@port}@#{@username}:#{@password}"
    end
  end
end
