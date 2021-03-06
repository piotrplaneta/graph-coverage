require "spec_helper"

describe GraphAdapters::GenericAdapter do
  let(:edges_param) do
    edges = ""
    edges += "1 2\n"
    edges += "3 4\n"
    edges += "4 1\n"
  end

  let(:start_nodes_param) { "1\n" }
  let(:end_nodes_param) { "4\n" }

  let(:def_nodes_param) { "1\n" }
  let(:use_nodes_param) { "4\n" }

  let(:coverage_type_param) { "prime" }

  let(:params) do
    params = {}
    params[:edges] = edges_param
    params[:start_nodes] = start_nodes_param
    params[:end_nodes] = end_nodes_param
    params[:def_nodes] = def_nodes_param
    params[:use_nodes] = use_nodes_param
    params[:coverage_type] = coverage_type_param
    params
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

  let(:def_nodes) { [nodes[1]] }
  let(:use_nodes) { [nodes[4]] }

  let(:proper_graph) do
    graph = Graph.new(nodes, edges, start_nodes, end_nodes)
    graph.def_nodes = def_nodes
    graph.use_nodes = use_nodes
    graph
  end

  describe "#graph with valid coverage strategy" do
    it "parses form params to proper graph" do
      expect(GraphAdapters::GenericAdapter.new(params).graph).to eq(proper_graph)
    end

    it "sets proper coverage strategy" do
      expect(GraphAdapters::GenericAdapter.new(params).graph.coverage_strategy).
        to(eq(CoverageStrategies::PrimeCoverage.new(proper_graph)))
    end

    it "sets proper def nodes" do
      expect(GraphAdapters::GenericAdapter.new(params).graph.def_nodes).
        to(eq(def_nodes))
    end

    it "sets proper use nodes" do
      expect(GraphAdapters::GenericAdapter.new(params).graph.use_nodes).
        to(eq(use_nodes))
    end

    describe "when lacking one of parameters" do
      let(:def_nodes_param) { nil }

      it "doesnt crash" do
        expect { GraphAdapters::GenericAdapter.new(params).graph }.
          to_not(raise_error)
      end
    end
  end

  describe "#graph with invalid coverage strategy" do
    let(:coverage_type_param) { "not_supported" }

    it "Raises an argument error" do
      expect { GraphAdapters::GenericAdapter.new(params).graph }.
        to(raise_error(ArgumentError))
    end
  end
end
