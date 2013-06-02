module NodeCoverage
  def coveraged_with?(test)
    return false if !test_valid?(test)

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

    return nil if paths.any? { |path| path == nil }

    Test.new(paths.uniq)
  end

  def path_through(node)
    if path_from_start_to(node) && path_to_end_from(node)
      nodes = path_from_start_to(node).nodes
      nodes.concat(path_to_end_from(node).nodes[1..-1])
      Path.new(nodes)
    end
  end

  def path_to_end_from(node)
    ending_condition = lambda { |node| end_nodes.include?(node) }
    path_from(node, ending_condition)
  end

  def path_from_start_to(ending_node)
    ending_condition = lambda { |node| node == ending_node }

    paths = start_nodes.collect do |start_node|
      path_from(start_node, ending_condition)
    end

    paths.find { |path| path != nil }
  end

  def can_reach_end_from?(node)
    path_to_end_from(node) != nil
  end

  def path_from(start_node, ending_condition)
    q = []
    visited = {}
    parents = {}
    q << start_node
    visited[start_node] = true

    while(!q.empty?)
      t = q.shift

      return retrieve_path_for(t, parents) if ending_condition.call(t)

      t.neighbours(edges).each do |n|
        if !visited[n]
          visited[n] = true
          parents[n] = t
          q << n
        end
      end
    end

    return nil
  end

  def retrieve_path_for(end_node, parents)
    path = []
    path << end_node

    current_node = end_node
    while(parents[current_node] != nil)
      current_node = parents[current_node]
      path.unshift(current_node)
    end

    Path.new(path)
  end

  def test_valid?(test)
    validation_results = test.paths.collect do |path|
      validate_start_and_end(path) && validate(path)
    end

    validation_results.inject(true) { |memo, result| memo && result }
  end

  def validate_start_and_end(path)
    start_nodes.include?(path.nodes[0]) &&
      end_nodes.include?(path.nodes[-1])
  end

  def validate(path)
    path.nodes.each_cons(2).all? do |node_pair|
      edges.include?(Edge.new(node_pair[0], node_pair[1]))
    end
  end
end
