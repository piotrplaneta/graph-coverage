module Extensions
  module EdgePairPathsGenerator
    def edge_pair_paths
      edges.flat_map do |first_edge|
        second_edges = edges.select do |second_edge|
          second_edge.source == first_edge.destination
        end

        edge_pair_paths_for(first_edge, second_edges)
      end
    end

    def edge_pair_paths_for(first_edge, second_edges)
      second_edges.map do |second_edge|
        Path.new([first_edge.source, first_edge.destination,
          second_edge.destination])
      end
    end
  end
end
