require "spec_helper"

describe Node do
  subject { Node.new(1) }

  describe "#neighbours" do
    let(:node2) { Node.new(2) }
    let(:node3) { Node.new(3) }
    let(:node4) { Node.new(4) }

    let(:edge1) { Edge.new(subject, node2) }
    let(:edge2) { Edge.new(subject, node3) }
    let(:edge3) { Edge.new(node2, node4) }

    let(:graph_edges) { [edge1, edge2, edge3] }

    it "returns proper node neighbours" do
      expect(subject.neighbours(graph_edges)).to match_array([node2, node3])
    end
  end
end
