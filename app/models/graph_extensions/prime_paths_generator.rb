module Extensions
  module PrimePathsGenerator
    def prime_paths
      paths = paths_from_edges

      changed = true
      while(changed)
        extended_paths = paths_extended_with_neighbours(paths)
        changed = !(extended_paths - paths).empty?
        paths = (paths + extended_paths)
      end

      paths_with_final_nodes = add_final_nodes(paths)
      without_subpaths(paths_with_final_nodes.uniq)
    end

    def without_subpaths(paths)
      paths.reject do |path|
        paths.any? { |other_path| path != other_path && path.subpath_of?(other_path) }
      end
    end

    def add_final_nodes(paths)
      paths + paths.flat_map do |path|
        with_final_node(path)
      end
    end

    def with_final_node(path)
      path.nodes[-1].neighbours(edges).map do |neighbour|
        if neighbour == path.nodes[0]
          path.with_node(neighbour)
        else
          path
        end
      end
    end

    def paths_extended_with_neighbours(paths)
      extended_paths = paths.flat_map do |path|
        paths_with_neighbours_of(path)
      end
      extended_paths.compact
    end

    def paths_with_neighbours_of(path)
      path.nodes[-1].neighbours(edges).map do |neighbour|
        if !path.include_node?(neighbour)
          path.with_node(neighbour)
        else
          nil
        end
      end
    end

    def paths_from_edges
      edges.collect do |edge|
        Path.new([edge.source, edge.destination])
      end
    end
  end
end
