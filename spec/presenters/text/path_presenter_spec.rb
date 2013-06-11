require "spec_helper"

describe Presenters::Text::PathPresenter do
  let(:path) { Path.new([Node.new(0), Node.new(1), Node.new(2)]) }

  describe "self.present" do
    it "returns proper description" do
      expect(Presenters::Text::PathPresenter.present(path)).to eq("0 -> 1 -> 2")
    end
  end
end
