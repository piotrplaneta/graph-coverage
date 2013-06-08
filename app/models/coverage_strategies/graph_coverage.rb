class GraphCoverage < Struct.new(:graph, :paths_to_cover)
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(graph))

    paths_to_cover.all? do |path_to_cover|
      test.paths.any? do |path|
        path_to_cover.subpath_of?(path)
      end
    end
  end

  def covering_test
    paths = paths_to_cover.collect do |path_to_cover|
      path_through(path_to_cover)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(path_to_cover)
    source = path_to_cover.nodes[0]
    destination = path_to_cover.nodes[-1]

    nodes_from_start_to_path_end = graph.path_from_start_to(source).nodes +
      path_to_cover.nodes[1..-2]

    nodes = nodes_from_start_to_path_end +
      graph.path_to_end_from(destination).nodes

    Path.new(nodes)
  end
end
