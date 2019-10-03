describe Proxin::Conclusion, type: :model do
  describe "#partial_success?" do
    context "when status is partial_success" do
      let!(:conclusion) { described_class.new }

      before { conclusion.instance_variable_set("@status", Proxin::ConclusionStatusType::PARTIAL_SUCCESS) }

      it "should response true" do
        expect(conclusion.partial_success?)
            .to be_truthy
      end
    end

    context "when status not partial_success" do
      let!(:conclusion) { described_class.new }

      before { conclusion.instance_variable_set("@status", nil) }

      it "should response false" do
        expect(conclusion.partial_success?)
            .to be_falsey
      end
    end
  end
end
