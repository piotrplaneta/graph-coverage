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
    edges << Edge.new(nodes[2], nodes[3])
    edges << Edge.new(nodes[3], nodes[1])
    edges << Edge.new(nodes[1], nodes[4])
    edges
  end

  let(:start_nodes) { [nodes[0]] }
  let(:end_nodes) { nodes[1..2] }

  subject { Graph.new(nodes, edges, start_nodes, end_nodes) }
  before { subject.extend(NodeCoverage) }

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

    describe "#node_coveraged?" do
      it "returns true if graph is node coveraged by test" do
        expect(subject).to be_coveraged_with(covering_test)
      end

      it "returns false if graph is node coveraged by test but test is invalid" do
        expect(subject).to_not be_coveraged_with(covering_invalid_test)
      end

      it "returns false if graph is not node coveraged by test" do
        expect(subject).to_not be_coveraged_with(uncovering_test)
      end
    end
  end

  describe "#can_reach_end_from" do
    before { subject.stub(:retrieve_path_for => Path.new(nodes[0])) }

    it "returns true for node from which U can reach end node" do
      expect(subject.can_reach_end_from?(nodes[3])).to be_true
    end

    it "returns false for node from which U cant reach end node" do
      expect(subject.can_reach_end_from?(nodes[4])).to be_false
    end
  end

  describe "#path_to_end_from" do
    it "returns proper path to one of end nodes if exists" do
      expect(subject.path_to_end_from(nodes[3])).to(
        eq(Path.new([nodes[3], nodes[1]]))
      )
    end

    it "returns nil if path to end doesnt exist" do
      expect(subject.path_to_end_from(nodes[4])).to be_nil
    end
  end

  describe "#path_from_start_to" do
    subject { Graph.new(nodes.concat([Node.new(5)]), edges, start_nodes, end_nodes) }

    it "returns proper path from one of starting nodes if exists" do
      expect(subject.path_from_start_to(nodes[4])).to(
        eq(Path.new([nodes[0], nodes[1], nodes[4]]))
      )
    end

    it "returns nil if path from start doesnt exist" do
      expect(subject.path_from_start_to(nodes[5])).to be_nil
    end
  end

  describe "#covering_test" do
    it "returns proper test node covering graph" do
      edges.concat([Edge.new(nodes[4], nodes[2])])
      expect(subject).to be_coveraged_with(subject.covering_test)
    end
  end
end
