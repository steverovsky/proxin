describe Proxin::Conclusion, type: :model do
  describe "#initialize_groups" do
    context "when call initialize" do
      let!(:conclusion) { described_class.new }

      it "should create alive, sick and dead groups" do
        expect(conclusion.groups.alive)
          .kind_of?(Array)
        expect(conclusion.groups.sick)
          .kind_of?(Array)
        expect(conclusion.groups.dead)
          .kind_of?(Array)
      end
    end
  end
end
