class Path < Struct.new(:nodes)
  def initialize(nodes = [])
    self.nodes = nodes
  end

  def add_node(node)
    nodes << node
  end

  def with_node(node)
    Path.new(nodes + [node])
  end

  def delete_node(node)
    nodes.delete(node)
  end

  def length
    nodes.length
  end

  def subpath_of?(other_path)
    return false if other_path.length < length

    other_path.nodes.each_cons(length).any? do |cons|
      cons == nodes
    end
  end

  def include_node?(node)
    nodes.include?(node)
  end

  def include_edge?(edge)
    return false if nodes.length < 2

    nodes.each_cons(2).any? do |pair|
      pair[0] == edge.source && pair[1] == edge.destination
    end
  end
end
