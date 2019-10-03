describe Proxin::Proxy, type: :model do
  context "#to_s" do
    context "when call #to_s" do
      let!(:attributes) do
        {
            ip: "192.168.0.1",
            port: "8080",
            username: "username-example",
            password: "password-example"
        }
      end
      let!(:proxy) { described_class.new(attributes) }

      it "should return proxy in string format" do
        expect(proxy.to_s)
          .to eq "192.168.0.1:8080@username-example:password-example"
      end
    end
  end
end
