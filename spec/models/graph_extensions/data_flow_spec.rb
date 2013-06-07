require "spec_helper"

describe Graph do
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

  subject { Graph.new(nodes, edges, start_nodes, end_nodes) }

  before { subject.def_nodes = [nodes[0]] }
  before { subject.use_nodes = nodes[4..5] }

  describe "#all_defs_paths" do
    let (:valid_all_defs_paths) do
      paths = []
      paths << Path.new([nodes[0], nodes[1], nodes[3], nodes[4]])
      paths << Path.new([nodes[0], nodes[2], nodes[3], nodes[4]])
      paths << Path.new([nodes[0], nodes[1], nodes[3], nodes[5]])
      paths << Path.new([nodes[0], nodes[2], nodes[3], nodes[5]])
    end

    it "returns valid all defs paths" do
      expect(subject.all_defs_paths.count).to eq(1)
      expect(valid_all_defs_paths).to include(*subject.all_uses_paths)
    end
  end

  describe "#all_uses_paths" do
    let(:edges) do
      edges = []
      edges << Edge.new(nodes[0], nodes[1])
      edges << Edge.new(nodes[1], nodes[3])
      edges << Edge.new(nodes[3], nodes[4])
      edges << Edge.new(nodes[3], nodes[5])
      edges << Edge.new(nodes[4], nodes[6])
      edges << Edge.new(nodes[5], nodes[6])
      edges
    end

    let (:valid_all_uses_paths) do
      paths = []
      paths << Path.new([nodes[0], nodes[1], nodes[3], nodes[4]])
      paths << Path.new([nodes[0], nodes[1], nodes[3], nodes[5]])
    end

    it "returns valid all uses paths" do
      expect(subject.all_uses_paths).to match_array(valid_all_uses_paths)
    end
  end
end
