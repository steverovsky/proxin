describe Proxin::Implementers::HTTPGetter do
  context "when response code is 200" do
    let!(:uri) { "https://example.ex" }
    let!(:response_code) { 200 }
    let!(:action) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:proxy) { Proxin::Proxy.new(ip: "192.168.0.1", port: "8080", username: nil, password: nil) }
    let!(:implementer) { described_class.new(action: action, proxy: proxy) }

    before do
      Typhoeus.stub(uri).and_return(Typhoeus::Response.new(code: response_code))

      implementer.call
    end

    it "should return Implementers::HTTPGetterOutput" do
      expect(implementer.output)
          .kind_of?(Proxin::Implementers::HTTPGetterOutput)
    end

    it "should return output with uri from action" do
      expect(implementer.output.uri)
          .to eq action.uri
    end

    it "should return output with status=success" do
      expect(implementer.output.status)
          .to eq Proxin::ImplementerStatusType::SUCCESS
    end

    it "should return output with response_code=200" do
      expect(implementer.output.response_code)
          .to eq 200
    end
  end

  context "when response code is 500" do
    let!(:uri) { "https://example.ex" }
    let!(:response_code) { 500 }
    let!(:action) { Proxin::Action::HTTPGetter.new(uri: uri) }
    let!(:proxy) { Proxin::Proxy.new(ip: "192.168.0.1", port: "8080", username: nil, password: nil) }
    let!(:implementer) { described_class.new(action: action, proxy: proxy) }

    before do
      Typhoeus.stub(uri).and_return(Typhoeus::Response.new(code: response_code))

      implementer.call
    end

    it "should return output with uri from action" do
      expect(implementer.output.uri)
        .to eq action.uri
    end

    it "should return output with status=failure" do
      expect(implementer.output.status)
          .to eq Proxin::ImplementerStatusType::FAILURE
    end

    it "should return output with response_code=500" do
      expect(implementer.output.response_code)
          .to eq 500
    end
  end
end