module AllDefsCoverage
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(self))

    all_defs_paths.all? do |all_defs_path|
      test.paths.any? do |path|
        all_defs_path.subpath_of?(path)
      end
    end
  end

  def covering_test
    paths = all_defs_paths.collect do |all_defs_path|
      path_through(all_defs_path)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(all_defs_path)
    source = all_defs_path.nodes[0]
    destination = all_defs_path.nodes[-1]

    nodes_from_start_to_path_end = path_from_start_to(source).nodes + all_defs_path.nodes[1..-2]
    nodes = nodes_from_start_to_path_end + path_to_end_from(destination).nodes
    Path.new(nodes)
  end
end
