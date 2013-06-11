require "spec_helper"

describe Presenters::Text::GraphPresenter do
  let(:nodes) { (0..4).map { |i| Node.new(i) } }

  let(:edges) do
    edges = []
    edges << Edge.new(nodes[1], nodes[2])
    edges << Edge.new(nodes[3], nodes[4])
    edges << Edge.new(nodes[4], nodes[1])
    edges
  end

  let(:start_nodes) { [nodes[1]] }
  let(:end_nodes) { [nodes[4]] }

  let(:def_nodes) { [nodes[2]] }
  let(:use_nodes) { [nodes[3]] }

  let(:graph) do
    graph = Graph.new(nodes, edges, start_nodes, end_nodes)
    graph.def_nodes = def_nodes
    graph.use_nodes = use_nodes
    graph
  end

  let(:proper_description) do
    text = "Nodes: 0, 1, 2, 3, 4<br />"
    text += "Edges: 1 -> 2, 3 -> 4, 4 -> 1<br />"
    text += "Start nodes: 1<br />"
    text += "End nodes: 4<br />"
    text += "Def nodes: 2<br />"
    text += "Use nodes: 3"
    text
  end

  describe "#to_text" do
    it "returns proper description" do
      expect(Presenters::Text::GraphPresenter.new(graph).to_text).
        to(eq(proper_description))
    end

    describe "without def or use nodes" do
      let(:graph) { Graph.new(nodes, edges, start_nodes, end_nodes) }

      let(:proper_description) do
        text = "Nodes: 0, 1, 2, 3, 4<br />"
        text += "Edges: 1 -> 2, 3 -> 4, 4 -> 1<br />"
        text += "Start nodes: 1<br />"
        text += "End nodes: 4"
        text
      end

      specify "doesnt include them in description" do
        expect(Presenters::Text::GraphPresenter.new(graph).to_text).
          to(eq(proper_description))
      end
    end
  end
end
