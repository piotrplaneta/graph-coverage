require "spec_helper"

describe Graph do
  let(:nodes) do
    nodes = []
    [0, 1, 2, 3].each do |id|
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
    edges << Edge.new(nodes[3], nodes[0])
    edges
  end

  let(:start_nodes) { [nodes[0]] }
  let(:end_nodes) { [nodes[3]] }

  subject { Graph.new(nodes, edges, start_nodes, end_nodes) }
  before { subject.extend(PrimeCoverage) }

  describe "coverage tests" do
    let(:covering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[0], nodes[2], nodes[3]])
      path2 = Path.new([nodes[0], nodes[2], nodes[3], nodes[0], nodes[1], nodes[3]])
      path3 = Path.new([nodes[0], nodes[1], nodes[3], nodes[0], nodes[1], nodes[3]])
      path4 = Path.new([nodes[0], nodes[2], nodes[3], nodes[0], nodes[2], nodes[3]])

      Test.new([path1, path2, path3, path4])
    end

    let(:uncovering_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[4]])
      path2 = Path.new([nodes[0], nodes[2], nodes[3]])

      Test.new([path1, path2])
    end

    let(:invalid_test) do
      path1 = Path.new([nodes[0], nodes[1], nodes[3], nodes[0], nodes[2]])
      path2 = Path.new([nodes[0], nodes[2], nodes[3], nodes[0], nodes[1]])
      path3 = Path.new([nodes[0], nodes[1], nodes[3], nodes[0], nodes[1]])
      path4 = Path.new([nodes[0], nodes[2], nodes[3], nodes[0], nodes[2]])

      Test.new([path1, path2, path3, path4])
    end

    describe "#covered_with?" do
      it "returns true if graph is prime covered by test" do
        expect(subject).to be_covered_with(covering_test)
      end

      it "returns false if graph is not prime covered by test" do
        expect(subject).to_not be_covered_with(uncovering_test)
      end

      it "returns false for invalid test" do
        expect(subject).to_not be_covered_with(invalid_test)
      end
    end
  end

  describe "#covering_test" do
    it "returns proper test prime covering graph" do
      expect(subject).to be_covered_with(subject.covering_test)
    end
  end
end
