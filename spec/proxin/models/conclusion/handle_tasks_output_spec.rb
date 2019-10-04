describe Proxin::Conclusion, type: :model do
  describe "#handle_tasks_output" do
    context "when call handle" do
      let!(:conclusion) { described_class.new }
      let!(:tasks) { ["example-of-task"] }

      it "should call group_tasks_by_proxies and update_status_by_groups" do
        expect(conclusion)
            .to receive(:build_reports).with(tasks)
        expect(conclusion)
          .to receive(:build_groups)
        expect(conclusion)
            .to receive(:update_status_by_groups)

        conclusion.handle_tasks_output(tasks)
      end
    end
  end
end
