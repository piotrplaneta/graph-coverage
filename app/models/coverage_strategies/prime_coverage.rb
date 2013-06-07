module PrimeCoverage
  def covered_with?(test)
    return false if(test.nil? || !test.valid_on?(self))

    prime_paths.all? do |prime_path|
      test.paths.any? do |path|
        prime_path.subpath_of?(path)
      end
    end
  end

  def covering_test
    paths = prime_paths.collect do |prime_path|
      path_through(prime_path)
    end

    return nil if paths.any?(&:nil?)

    Test.new(paths.uniq)
  end

  def path_through(prime_path)
    source = prime_path.nodes[0]
    destination = prime_path.nodes[-1]

    nodes_from_start_to_path_end = path_from_start_to(source).nodes + prime_path.nodes[1..-2]
    nodes = nodes_from_start_to_path_end + path_to_end_from(destination).nodes
    Path.new(nodes)
  end
end
