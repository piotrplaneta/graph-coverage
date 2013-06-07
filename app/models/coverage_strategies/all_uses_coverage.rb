module AllUsesCoverage
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(self))

    all_uses_paths.all? do |all_uses_path|
      test.paths.any? do |path|
        all_uses_path.subpath_of?(path)
      end
    end
  end

  def covering_test
    paths = all_uses_paths.collect do |all_uses_path|
      path_through(all_uses_path)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(all_uses_path)
    source = all_uses_path.nodes[0]
    destination = all_uses_path.nodes[-1]

    nodes_from_start_to_path_end = path_from_start_to(source).nodes + all_uses_path.nodes[1..-2]
    nodes = nodes_from_start_to_path_end + path_to_end_from(destination).nodes
    Path.new(nodes)
  end
end
