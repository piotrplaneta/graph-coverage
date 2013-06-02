module Extensions
  module PrimePathsGenerator
    def prime_paths
      paths = paths_from_edges

      changed = true
      while(changed)
        changed = false

        paths.flat_map do |path|
          enlarged_paths(path)
        end
      end
    end

    def enlarged_paths(path)
    end

    def paths_from_edges
      edges.collect do |edge|
        Path.new([edge.source, edge.destination])
      end
    end
  end
end
