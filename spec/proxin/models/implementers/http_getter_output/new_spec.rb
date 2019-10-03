describe Proxin::Implementers::HTTPGetterOutput, type: :model do
  context "when create object" do
    context "when full set of attributes presented" do
      let!(:attributes) do
        {
            uri: "https://example.ex",
            status: Proxin::ImplementerStatusType::SUCCESS,
            response_code: 200
        }
      end
      let!(:action_http_output) { described_class.new(attributes) }

      it "should create Proxin::Implementers::HTTPGetterOutput object with expected attributes" do
        expect(action_http_output.uri)
            .to eq attributes[:uri]
        expect(action_http_output.status)
            .to eq attributes[:status]
        expect(action_http_output.response_code)
            .to eq attributes[:response_code]
      end
    end
  end
end
