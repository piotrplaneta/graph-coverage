require "spec_helper"

describe Presenters::Text::TestPresenter do
  let(:paths) do
    paths = []
    paths << Path.new([Node.new(0), Node.new(1), Node.new(2)])
    paths << Path.new([Node.new(4), Node.new(5), Node.new(6)])
    paths
  end

  let(:test) { Test.new(paths) }

  describe "self.present" do
    it "returns proper description" do
      expect(Presenters::Text::TestPresenter.present(test)).
        to(eq("0 -> 1 -> 2<br />4 -> 5 -> 6"))
    end
  end
end
