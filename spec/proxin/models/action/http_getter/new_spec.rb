describe Proxin::Action::HTTPGetter, type: :model do
  context "when create object" do
    context "when full set of attributes presented" do
      let!(:attributes) { { uri: "https://example.ex"} }
      let!(:action_http_getter) { described_class.new(attributes) }

      it "should create Proxin::Action::HTTPGetter object with expected attributes" do
        expect(action_http_getter.uri)
            .to eq attributes[:uri]
      end
    end
  end
end
