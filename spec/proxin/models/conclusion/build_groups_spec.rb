describe Proxin::Conclusion, type: :model do
  describe "#build_groups" do
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
          alive: [proxy_1],
          sick: [proxy_3],
          dead: [proxy_2]
        }
      end


      it "should build groups" do
        conclusion.send(:build_reports, tasks)
        conclusion.send(:build_groups)

        expect(conclusion.groups.alive)
            .to contain_exactly(*expected_groups[:alive])
        expect(conclusion.groups.sick)
            .to contain_exactly(*expected_groups[:sick])
        expect(conclusion.groups.dead)
            .to contain_exactly(*expected_groups[:dead])
      end
    end
  end
end
