require "spec_helper"

describe CoverageStrategies::AllDefsCoverage do
  let(:nodes) do
    nodes = []
    [0, 1, 2, 3, 4, 5, 6].each do |id|
      nodes << Node.new(id)
    end
    nodes
  end

  let(:edges) do
    edges = []
    edges << Edge.new(nodes[0], nodes[1])
    edges << Edge.new(nodes[0], nodes[2])
    edges << Edge.new(nodes[1], nodes[3])
    edges << Edge.new(nodes[2], nodes[3])
    edges << Edge.new(nodes[3], nodes[4])
    edges << Edge.new(nodes[3], nodes[5])
    edges << Edge.new(nodes[4], nodes[6])
    edges << Edge.new(nodes[5], nodes[6])
    edges
  end

  let(:start_nodes) { [nodes[0]] }
  let(:end_nodes) { [nodes[6]] }
  let(:def_nodes) { [nodes[0]] }
  let(:use_nodes) { [nodes[4]] }

  subject do
    graph = Graph.new(nodes, edges, start_nodes, end_nodes)
    graph.def_nodes = def_nodes
    graph.use_nodes = use_nodes

    graph.coverage_strategy = CoverageStrategies::AllDefsCoverage.new(graph)
  end

  describe "coverage tests" do
    let(:covering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[4], nodes[6]])
      path2 = Path.new([nodes[0], nodes[2], nodes[3], nodes[4], nodes[6]])

      Test.new([path1, path2])
    end

    let(:uncovering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[5], nodes[6]])
      path2 = Path.new([nodes[0], nodes[2], nodes[3], nodes[5], nodes[6]])

      Test.new([path1, path2])
    end

    let(:invalid_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[4], nodes[5], nodes[6]])

      Test.new([path1])
    end

    describe "#covered_with?" do
      it "returns true if graph is all defs covered by test" do
        expect(subject).to be_covered_with(covering_test)
      end

      it "returns false if graph is not all defs covered by test" do
        expect(subject).to_not be_covered_with(uncovering_test)
      end

      it "returns false for invalid test" do
        expect(subject).to_not be_covered_with(invalid_test)
      end
    end
  end

  describe "#covering_test" do
    it "returns proper test all defs covering graph" do
      expect(subject).to be_covered_with(subject.covering_test)
    end
  end
end
