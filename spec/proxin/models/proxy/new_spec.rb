describe Proxin::Proxy, type: :model do
  context "when create object" do
    context "when full set of attributes presented" do
      let!(:attributes) do
        {
          ip: "192.168.0.1",
          port: "8080",
          username: "username-example",
          password: "password-example"
        }
      end
      let!(:proxy) { described_class.new(attributes) }

      it "should create Proxin::Proxy object with expected attributes" do
        aggregate_failures do
          expect(proxy.ip)
            .to eq attributes[:ip]
          expect(proxy.port)
              .to eq attributes[:port]
          expect(proxy.username)
              .to eq attributes[:username]
          expect(proxy.password)
              .to eq attributes[:password]
        end
      end
    end
  end
end
