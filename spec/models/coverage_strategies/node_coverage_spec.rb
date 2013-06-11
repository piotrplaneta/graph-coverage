require "spec_helper"

describe CoverageStrategies::NodeCoverage do
  let(:nodes) do
    nodes = []
    [0, 1, 2, 3, 4].each do |id|
      nodes << Node.new(id)
    end
    nodes
  end

  let(:edges) do
    edges = []
    edges << Edge.new(nodes[0], nodes[1])
    edges << Edge.new(nodes[0], nodes[2])
    edges << Edge.new(nodes[2], nodes[3])
    edges << Edge.new(nodes[3], nodes[1])
    edges << Edge.new(nodes[1], nodes[4])
    edges
  end

  let(:start_nodes) { [nodes[0]] }
  let(:end_nodes) { nodes[1..2] }

  subject do
    graph = Graph.new(nodes, edges, start_nodes, end_nodes)
    graph.coverage_strategy = CoverageStrategies::NodeCoverage.new(graph)
  end

  describe "coverage tests" do
    let(:end_nodes) { nodes[3..4] }

    let(:covering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[4]])
      path2 = Path.new([nodes[0], nodes[2], nodes[3]])

      Test.new([path1, path2])
    end

    let(:covering_invalid_test) do
      path1 = Path.new(nodes)

      Test.new([path1])
    end

    let(:uncovering_test) do
      path1 = Path.new(nodes[0..3])

      Test.new([path1])
    end

    describe "#covered_with?" do
      it "returns true if graph is node covered by test" do
        expect(subject).to be_covered_with(covering_test)
      end

      it "returns false if graph is node covered by test but test is invalid" do
        expect(subject).to_not be_covered_with(covering_invalid_test)
      end

      it "returns false if graph is not node covered by test" do
        expect(subject).to_not be_covered_with(uncovering_test)
      end
    end
  end

  describe "#covering_test" do
    it "returns proper test node covering graph" do
      edges.concat([Edge.new(nodes[4], nodes[2])])
      expect(subject).to be_covered_with(subject.covering_test)
    end
  end
end
