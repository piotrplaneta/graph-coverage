module EdgeCoverage
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(self))

    edges.all? do |edge|
      test.paths.any? do |path|
        path.include_edge?(edge)
      end
    end
  end

  def covering_test
    paths = edges.collect do |edge|
      path_through(edge)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(edge)
    if path_from_start_to(edge.source) && path_to_end_from(edge.destination)
      nodes = path_from_start_to(edge.source).nodes.concat(
        path_to_end_from(edge.destination).nodes
      )
      Path.new(nodes)
    end
  end
end
