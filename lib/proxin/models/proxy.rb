module Proxin
  class Proxy
    attr_reader :ip,
                  :port,
                  :username,
                  :password

    def initialize(ip:, port:, username:, password:)
      @ip = ip
      @port = port
      @username = username
      @password = password
    end

    def to_s
      "#{@ip}:#{@port}@#{@username}:#{@password}"
    end
  end
end
