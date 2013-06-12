require "spec_helper"

describe Helpers::CoverageHelper do
  before { Helpers::CoverageHelper.any_instance.stub(:edges_json => "edges") }
  before { Helpers::CoverageHelper.any_instance.stub(:graph_text => "graph") }
  before { Helpers::CoverageHelper.any_instance.stub(:test_text => "test") }


  describe "#locals" do
    context "with json format" do
      let(:valid_locals) do
        valid_locals = {}
        valid_locals[:text_of_test] = "test"
        valid_locals[:text_of_graph] = "graph"
        valid_locals[:edges_json] = "edges"
        valid_locals
      end

      it "returns valid locals" do
        expect(Helpers::CoverageHelper.new(nil, "json").locals).
          to(eq(valid_locals))
      end
    end

    context "with text format" do
      let(:valid_locals) do
        valid_locals = {}
        valid_locals[:text_of_test] = "test"
        valid_locals[:text_of_graph] = "graph"
        valid_locals[:edges_json] = nil
        valid_locals
      end
      it "returns valid locals" do
        expect(Helpers::CoverageHelper.new(nil, "text").locals).
          to(eq(valid_locals))
      end
    end
  end
end
