require "spec_helper"

describe GraphAdapters::FileAdapter do
  let(:file_content) { "1 2\n3 4\n4 1\n-\n1\n-\n4\n-\n2\n-\n3\n-\nprime\n" }
  let(:filename) { "faked_filename" }

  before do
    GraphAdapters::FileAdapter.any_instance.
      stub(:file_content => file_content)
  end

  let(:nodes) { (0..4).map { |i| Node.new(i) } }

  let(:edges) do
    edges = []
    edges << Edge.new(nodes[1], nodes[2])
    edges << Edge.new(nodes[3], nodes[4])
    edges << Edge.new(nodes[4], nodes[1])
    edges
  end

  let(:start_nodes) { [nodes[1]] }
  let(:end_nodes) { [nodes[4]] }

  let(:def_nodes) { [nodes[2]] }
  let(:use_nodes) { [nodes[3]] }

  let(:proper_graph) do
    graph = Graph.new(nodes, edges, start_nodes, end_nodes)
    graph.def_nodes = def_nodes
    graph.use_nodes = use_nodes
    graph
  end

  describe "#graph with valid coverage strategy" do
    it "parses form params to proper graph" do
      expect(GraphAdapters::FileAdapter.new(filename).graph).to eq(proper_graph)
    end

    it "sets proper coverage strategy" do
      expect(GraphAdapters::FileAdapter.new(filename).graph.coverage_strategy).
        to(eq(CoverageStrategies::PrimeCoverage.new(proper_graph)))
    end

    it "sets proper def nodes" do
      expect(GraphAdapters::FileAdapter.new(filename).graph.def_nodes).
        to(eq(def_nodes))
    end

    it "sets proper use nodes" do
      expect(GraphAdapters::FileAdapter.new(filename).graph.use_nodes).
        to(eq(use_nodes))
    end

    describe "when lacking one of parameters" do
      let(:def_nodes_param) { nil }

      it "doesnt crash" do
        expect { GraphAdapters::FileAdapter.new(filename).graph }.
          to_not(raise_error)
      end
    end
  end
end
