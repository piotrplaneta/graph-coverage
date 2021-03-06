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

  let(:proper_edge_pair_paths) do
    paths = []
    paths << Path.new([nodes[0], nodes[1], nodes[3]])
    paths << Path.new([nodes[0], nodes[2], nodes[4]])
    paths << Path.new([nodes[1], nodes[3], nodes[2]])
    paths << Path.new([nodes[2], nodes[4], nodes[1]])
    paths << Path.new([nodes[3], nodes[2], nodes[4]])
    paths << Path.new([nodes[4], nodes[1], nodes[3]])
    paths
  end

  subject { Graph.new(nodes, edges, start_nodes, end_nodes) }

  describe "#edge_pair_paths" do
    it "generates proper paths" do
      expect(subject.edge_pair_paths).to match_array(proper_edge_pair_paths)
    end
  end
end
