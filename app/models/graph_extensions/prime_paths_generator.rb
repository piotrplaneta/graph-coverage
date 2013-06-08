module Extensions
  module PrimePathsGenerator
    def prime_paths
      paths = paths_from_edges

      changed = true
      while(changed)
        extended_paths = paths_extended_with_neighbours(paths)
        changed = !(extended_paths - paths).empty?
        paths = (paths | extended_paths)
      end

      paths_with_final_nodes = add_final_nodes(paths)
      without_subpaths(paths_with_final_nodes)
    end

    def without_subpaths(paths)
      paths.reject do |path|
        paths.any? { |other_path| path != other_path && path.subpath_of?(other_path) }
      end
    end

    def add_final_nodes(paths)
      path_with_final_nodes = paths.flat_map do |path|
        with_final_node(path)
      end
      paths | path_with_final_nodes.compact
    end

    def with_final_node(path)
      path.nodes[-1].neighbours(edges).inject([]) do |paths, neighbour|
        if neighbour == path.nodes[0]
          paths << path.with_node(neighbour)
        else
          paths
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
      path.nodes[-1].neighbours(edges).inject([]) do |paths, neighbour|
        if !path.include_node?(neighbour)
          paths << path.with_node(neighbour)
        else
          paths
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
