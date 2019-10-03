describe Proxin::Boiler do
  context "when unexpected action class" do
    let!(:action) { double }
    let!(:proxy) { Proxin::Proxy.new(ip: "192.168.0.1", port: "8080", username: nil, password: nil) }
    let!(:boiler) { described_class.new([proxy], [action]) }

    it "should raise NotImplemented exception" do
      expect{ boiler.call }
        .to raise_exception(NotImplementedError)
    end
  end

  context "when action class is HTTPGetter" do
    let!(:uri) { "https://example.ex" }
    let!(:action) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:proxy) { Proxin::Proxy.new(ip: "192.168.0.1", port: "8080", username: nil, password: nil) }
    let!(:boiler) { described_class.new([proxy], [action]) }
    let!(:implementer_action_doubler) { double(Proxin::Implementers::HTTPGetter) }
    let!(:implementer_action_expect) do
      -> {
        expect(Proxin::Implementers::HTTPGetter)
            .to receive(:new).with(action: action, proxy: proxy).and_return(implementer_action_doubler)
        expect(implementer_action_doubler)
            .to receive(:call)
        expect(implementer_action_doubler)
            .to receive(:output).and_return({})
      }
    end
    let!(:conclusion_expect) do
      -> {
        conclusion_mock = double(Proxin::Conclusion, success?: true)
        expect(Proxin::Conclusion)
            .to receive(:new).and_return(conclusion_mock)
        expect(conclusion_mock)
            .to receive(:handle_tasks_output).with([{ action: action, proxy: proxy, output: {} }])
      }
    end

    it "should call HTTPGetter implementer" do
      implementer_action_expect.call
      conclusion_expect.call

      boiler.call
    end

    it "should #handle_tasks_output on conclusion with tasks" do
      implementer_action_expect.call
      conclusion_expect.call

      boiler.call
    end

    it "should create tasks" do
      implementer_action_expect.call
      conclusion_expect.call

      boiler.call

      expect(boiler.tasks)
        .to contain_exactly({ action: action, proxy: proxy, output: {} })
    end

    it "should create conclusion" do
      implementer_action_expect.call
      conclusion_expect.call

      boiler.call

      expect(boiler.conclusion)
        .kind_of?(Proxin::Conclusion)
    end
  end
end
