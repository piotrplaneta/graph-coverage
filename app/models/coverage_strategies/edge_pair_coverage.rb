require_relative "graph_coverage"

class EdgePairCoverage < GraphCoverage
  def initialize(graph)
    super(graph, graph.edge_pair_paths)
  end
end
