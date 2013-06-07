module Extensions
  module DataFlow
    attr_accessor :def_nodes, :use_nodes

    def all_defs_paths
      ending_condition = lambda { |node| use_nodes.include?(node) }

      def_nodes.map do |def_node|
        path_from(def_node, ending_condition)
      end
    end

    def all_uses_paths
      def_nodes.flat_map do |def_node|
        use_nodes.map do |use_node|
          ending_condition = lambda { |node| node == use_node }
          path_from(def_node, ending_condition)
        end
      end
    end
  end
end
