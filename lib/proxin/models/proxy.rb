module Proxin
  class Proxy
    attr_reader :ip,
                :port,
                :username,
                :password,
                :status

    # proxy.reports(action: :http_getter)
    # TODO: proxy.summary => summary of all actions
    #   -- response_code
    #   -- response_message
    #   -- response_time
    #   -- ping
    #   -- ttfb
    #   -- anonymity_level
    #   -- supported_protocols
    #   -- download_speed

    def initialize(ip:, port:, username: nil, password: nil)
      @ip = ip
      @port = port
      @username = username
      @password = password

      initialize_status
      initialize_reports
    end

    def connection_settings
      {
        ip: @ip,
        port: @port,
        username: @username,
        password: @password
      }
    end

    def to_s
      "#{@ip}:#{@port}@#{@username}:#{@password}"
    end

    def proxyuserpwd
      "#{@username}:#{@password}"
    end

    def write_reports(reports)
      @reports = reports
      @status = determine_status_by_reports
    end

    def reports(report_statuses: [])
      return @reports if report_statuses.nil?

      @reports.select { |report| report_statuses.include?(report.output.status) }
    end

    private

    def initialize_status
      @status = ProxyStatusType::UNCHECKED
    end

    def initialize_reports
      @reports = []
    end

    def determine_status_by_reports
      if reports(report_statuses: [ImplementerStatusType::FAILURE, ImplementerStatusType::UNCHECKED]).empty?
        @status = ProxyStatusType::ALIVE
      elsif !reports(report_statuses: [ImplementerStatusType::SUCCESS, ImplementerStatusType::UNCHECKED]).empty?
        @status = ProxyStatusType::SICK
      else
        @status = ProxyStatusType::DEAD
      end
    end
  end
end
