require 'spec_helper'

describe Proxin do
  context "when getting version" do
    it "should return current version" do
      expect(Proxin::VERSION)
        .to eq "0.0.1"
    end
  end
end
