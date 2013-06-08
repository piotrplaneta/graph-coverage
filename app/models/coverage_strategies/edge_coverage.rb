require_relative "graph_coverage"

class EdgeCoverage < GraphCoverage
  def initialize(graph)
    super(graph, paths_from_edges(graph))
  end

  private
  def paths_from_edges(graph)
    graph.edges.map do |edge|
      Path.new([edge.source, edge.destination])
    end
  end
end
