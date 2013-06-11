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
      expect(subject.path_to_end_from(nodes[3])).
        to(eq(Path.new([nodes[3], nodes[1]])))
    end

    it "returns nil if path to end doesnt exist" do
      expect(subject.path_to_end_from(nodes[4])).to be_nil
    end
  end

  describe "#path_from_start_to" do
    subject { Graph.new(nodes.concat([Node.new(5)]), edges, start_nodes, end_nodes) }

    it "returns proper path from one of starting nodes if exists" do
      expect(subject.path_from_start_to(nodes[4])).
        to(eq(Path.new([nodes[0], nodes[1], nodes[4]])))
    end

    it "returns nil if path from start doesnt exist" do
      expect(subject.path_from_start_to(nodes[5])).to be_nil
    end
  end
end
