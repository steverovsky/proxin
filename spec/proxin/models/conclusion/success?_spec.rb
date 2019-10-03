describe Proxin::Conclusion, type: :model do
  describe "#success?" do
    context "when status is success" do
      let!(:conclusion) { described_class.new }

      before { conclusion.instance_variable_set("@status", Proxin::ConclusionStatusType::SUCCESS) }

      it "should response true" do
        expect(conclusion.success?)
          .to be_truthy
      end
    end

    context "when status not success" do
      let!(:conclusion) { described_class.new }

      before { conclusion.instance_variable_set("@status", nil) }

      it "should response false" do
        expect(conclusion.success?)
            .to be_falsey
      end
    end
  end
end
