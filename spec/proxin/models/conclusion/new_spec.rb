describe Proxin::Conclusion, type: :model do
  context "when create object" do
    it "should call initialize_groups" do
      expect_any_instance_of(described_class)
        .to receive(:initialize_groups)

      described_class.new
    end
  end
end
