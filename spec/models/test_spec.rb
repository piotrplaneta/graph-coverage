require "spec_helper"

describe Test do
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
  let(:end_nodes) { nodes[3..4] }

  let(:graph) { Graph.new(nodes, edges, start_nodes, end_nodes) }

  let(:valid_test) do
    path1 = Path.new([nodes[0], nodes[1], nodes[4]])
    path2 = Path.new([nodes[0], nodes[2], nodes[3]])

    Test.new([path1, path2])
  end

  let(:invalid_test) do
    path1 = Path.new(nodes)

    Test.new([path1])
  end

  describe "#valid_on?" do
    it "returns true if test is valid on given graph" do
      expect(valid_test).to be_valid_on(graph)
    end
  end
end

