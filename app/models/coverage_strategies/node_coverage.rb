module NodeCoverage
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(self))

    nodes.all? do |node|
      test.paths.any? do |path|
        path.include_node?(node)
      end
    end
  end

  def covering_test
    paths = nodes.collect do |node|
      path_through(node)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(node)
    if path_from_start_to(node) && path_to_end_from(node)
      nodes = path_from_start_to(node).nodes
      nodes.concat(path_to_end_from(node).nodes[1..-1])
      Path.new(nodes)
    end
  end
end
