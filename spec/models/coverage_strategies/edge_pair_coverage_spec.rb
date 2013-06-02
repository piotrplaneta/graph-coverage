require "spec_helper"

describe Graph do
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
    edges << Edge.new(nodes[1], nodes[3])
    edges << Edge.new(nodes[2], nodes[4])
    edges << Edge.new(nodes[3], nodes[2])
    edges << Edge.new(nodes[4], nodes[1])
    edges
  end

  let(:start_nodes) { [nodes[0]] }
  let(:end_nodes) { nodes[3..4] }

  subject { Graph.new(nodes, edges, start_nodes, end_nodes) }
  before { subject.extend(EdgePairCoverage) }

  describe "coverage tests" do

    let(:covering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[2], nodes[4]])
      path2 = Path.new([nodes[0], nodes[2], nodes[4], nodes[1], nodes[3]])

      Test.new([path1, path2])
    end

    let(:uncovering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[2], nodes[4]])

      Test.new([path1])
    end

    describe "#coveraged_with?" do
      it "returns true if graph is edge pair covered by test" do
        expect(subject).to be_covered_with(covering_test)
      end

      it "returns false if graph is not edge pair covered by test" do
        expect(subject).to_not be_covered_with(uncovering_test)
      end
    end
  end

  describe "#covering_test" do
    it "returns proper test edge covering graph" do
      expect(subject).to be_covered_with(subject.covering_test)
    end
  end
end
