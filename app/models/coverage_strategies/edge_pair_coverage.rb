module EdgePairCoverage
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(self))

    edge_pair_paths.all? do |edge_pair|
      test.paths.any? do |path|
        edge_pair.subpath_of?(path)
      end
    end
  end

  def covering_test
    paths = edge_pair_paths.collect do |edge_pair|
      path_through(edge_pair)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(edge_pair)
    edge_pair_nodes = edge_pair.nodes
    if path_from_start_to(edge_pair_nodes[0]) && path_to_end_from(edge_pair_nodes[2])
      nodes = path_from_start_to(edge_pair_nodes[0]).nodes.concat(
        [edge_pair_nodes[1]].concat(path_to_end_from(edge_pair_nodes[2]).nodes)
      )

      Path.new(nodes)
    end
  end
end
