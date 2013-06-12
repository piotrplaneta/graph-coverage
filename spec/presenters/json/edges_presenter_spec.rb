require "spec_helper"

describe Presenters::Json::EdgesPresenter do
  let(:edges) do
    edges = []
    edges << Edge.new(Node.new(0), Node.new(1))
    edges << Edge.new(Node.new(1), Node.new(2))
  end

  let(:proper_json) do
    "[{\"source\":\"0\",\"destination\":\"1\"},{\"source\":\"1\",\"destination\":\"2\"}]"
  end

  describe "#to_json" do
    it "returns proper description" do
      expect(Presenters::Json::EdgesPresenter.new(edges).to_json).
        to(eq(proper_json))
    end
  end
end
