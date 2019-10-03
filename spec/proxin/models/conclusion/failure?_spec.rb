describe Proxin::Conclusion, type: :model do
  describe "#failure?" do
    context "when status is failure" do
      let!(:conclusion) { described_class.new }

      before { conclusion.instance_variable_set("@status", Proxin::ConclusionStatusType::FAILURE) }

      it "should response true" do
        expect(conclusion.failure?)
            .to be_truthy
      end
    end

    context "when status not failure" do
      let!(:conclusion) { described_class.new }

      before { conclusion.instance_variable_set("@status", nil) }

      it "should response false" do
        expect(conclusion.failure?)
            .to be_falsey
      end
    end
  end
end
