require_relative "graph_coverage"

class AllDefsCoverage < GraphCoverage
  def initialize(graph)
    super(graph, graph.all_defs_paths)
  end
end

