describe Proxin::Conclusion, type: :model do
  describe "#group_tasks_by_proxies" do
    context "when call handle" do
      let!(:uri) { "https://example.ex" }
      let!(:action_1) { Proxin::Action::HTTPGetter.new(uri: uri) }
      let!(:action_2) { Proxin::Action::HTTPGetter.new(uri: uri) }
      let!(:action_3) { Proxin::Action::HTTPGetter.new(uri: uri) }
      let!(:action_4) { Proxin::Action::HTTPGetter.new(uri: uri) }
      let!(:proxy_1) { Proxin::Proxy.new(ip: "192.168.0.1", port: "8080", username: nil, password: nil) }
      let!(:proxy_2) { Proxin::Proxy.new(ip: "192.168.0.2", port: "8080", username: nil, password: nil) }
      let!(:proxy_3) { Proxin::Proxy.new(ip: "192.168.0.3", port: "8080", username: nil, password: nil) }
      let!(:conclusion) { described_class.new }
      let!(:tasks) do
        [
          { proxy: proxy_1, action: action_1, output: double(status: Proxin::ImplementerStatusType::SUCCESS) },
          { proxy: proxy_2, action: action_2, output: double(status: Proxin::ImplementerStatusType::FAILURE) },
          { proxy: proxy_3, action: action_3, output: double(status: Proxin::ImplementerStatusType::SUCCESS) },
          { proxy: proxy_3, action: action_4, output: double(status: Proxin::ImplementerStatusType::FAILURE) },
        ]
      end
      let!(:expected_groups) do
        {
          "192.168.0.1:8080@:" => {
            proxy: proxy_1,
            reports: [
              Proxin::ProxyReport.new(action: tasks[0][:action], output: tasks[0][:output])
            ]
          },
          "192.168.0.2:8080@:" => {
            proxy: proxy_2,
            reports: [
              Proxin::ProxyReport.new(action: tasks[1][:action], output: tasks[1][:output])
            ]
          },
          "192.168.0.3:8080@:" => {
            proxy: proxy_3,
            reports: [
              Proxin::ProxyReport.new(action: tasks[2][:action], output: tasks[2][:output]),
              Proxin::ProxyReport.new(action: tasks[3][:action], output: tasks[3][:output])
            ]
          }
        }
      end

      it "should group by proxies" do
        expect(conclusion.send(:group_tasks_by_proxies, tasks))
          .to eq(expected_groups)
      end
    end
  end
end
