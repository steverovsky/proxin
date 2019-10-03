require "ostruct"

describe Proxin::Conclusion, type: :model do
  describe "#update_status_by_groups" do
    let!(:uri) { "https://example.ex" }
    let!(:action_1) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:action_2) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:action_3) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:action_4) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:proxy_1) { Proxin::Proxy.new(ip: "192.168.0.1", port: "8080", username: nil, password: nil) }
    let!(:proxy_2) { Proxin::Proxy.new(ip: "192.168.0.2", port: "8080", username: nil, password: nil) }
    let!(:proxy_3) { Proxin::Proxy.new(ip: "192.168.0.3", port: "8080", username: nil, password: nil) }
    let!(:tasks) do
      [
          { proxy: proxy_1, action: action_1, output: double(status: Proxin::ImplementerStatusType::SUCCESS) },
          { proxy: proxy_2, action: action_2, output: double(status: Proxin::ImplementerStatusType::FAILURE) },
          { proxy: proxy_3, action: action_3, output: double(status: Proxin::ImplementerStatusType::SUCCESS) },
          { proxy: proxy_3, action: action_4, output: double(status: Proxin::ImplementerStatusType::FAILURE) },
      ]
    end

    subject { described_class.new }

    context "when groups empty" do
      let!(:conclusion) { described_class.new }
      let!(:groups) { OpenStruct.new(alive: [], sick: [], dead: []) }

      before do
        conclusion.instance_variable_set("@groups", groups)

        conclusion.send(:update_status_by_groups)
      end

      it "should set status is success" do
        expect(conclusion.status)
            .to eq Proxin::ConclusionStatusType::SUCCESS
      end
    end

    context "when sick and dead empty" do
      let!(:groups) do
        OpenStruct.new(
          alive: [
            { proxy: proxy_1, successful_tasks: [tasks[0]], failed_tasks: [] }
          ],
          sick: [],
          dead: []
        )
      end

      before do
        subject.instance_variable_set("@groups", groups)
        subject.send(:update_status_by_groups)
      end

      it "should set status is success" do
        expect(subject.status)
          .to eq Proxin::ConclusionStatusType::SUCCESS
      end
    end

    context "when alive and sick empty" do
      let!(:groups) do
        OpenStruct.new(
          alive: [],
          sick: [],
          dead: [
            { proxy: proxy_2, successful_tasks: [], failed_tasks: [tasks[1]] }
          ]
        )
      end

      before do
        subject.instance_variable_set("@groups", groups)
        subject.send(:update_status_by_groups)
      end

      it "should set status is failure" do
        expect(subject.status)
            .to eq Proxin::ConclusionStatusType::FAILURE
      end
    end

    context "when mixed alive and sick" do
      let!(:groups) do
        OpenStruct.new(
          alive: [],
          sick: [
            { proxy: proxy_3, successful_tasks: [tasks[2]], failed_tasks: [tasks[3]] }
          ],
          dead: [
            { proxy: proxy_2, successful_tasks: [], failed_tasks: [tasks[1]] }
          ]
        )
      end

      before do
        subject.instance_variable_set("@groups", groups)
        subject.send(:update_status_by_groups)
      end

      it "should set status is partial_success" do
        expect(subject.status)
            .to eq Proxin::ConclusionStatusType::PARTIAL_SUCCESS
      end
    end

    context "when mixed alive and dead" do
      let!(:groups) do
        OpenStruct.new(
          alive: [],
          sick: [
            { proxy: proxy_3, successful_tasks: [tasks[2]], failed_tasks: [tasks[3]] }
          ],
          dead: [
          ]
        )
      end

      before do
        subject.instance_variable_set("@groups", groups)
        subject.send(:update_status_by_groups)
      end

      it "should set status is partial_success" do
        expect(subject.status)
            .to eq Proxin::ConclusionStatusType::PARTIAL_SUCCESS
      end
    end

    context "when only sick" do
      let!(:groups) do
        OpenStruct.new(
          alive: [
            { proxy: proxy_1, successful_tasks: [tasks[0]], failed_tasks: [] }
          ],
          sick: [],
          dead: [
              { proxy: proxy_2, successful_tasks: [], failed_tasks: [tasks[1]] }
          ]
        )
      end

      before do
        subject.instance_variable_set("@groups", groups)
        subject.send(:update_status_by_groups)
      end

      it "should set status is partial_success" do
        expect(subject.status)
          .to eq Proxin::ConclusionStatusType::PARTIAL_SUCCESS
      end
    end
  end
end
