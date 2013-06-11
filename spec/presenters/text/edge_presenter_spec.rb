require "spec_helper"

describe Presenters::Text::EdgePresenter do
  let(:edge) { Edge.new(Node.new(0), Node.new(1)) }

  describe "#to_text" do
    it "returns proper description" do
      expect(Presenters::Text::EdgePresenter.new(edge).to_text).to eq("0 -> 1")
    end
  end
end
