module Extensions
  module Bfs
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
  end
end

