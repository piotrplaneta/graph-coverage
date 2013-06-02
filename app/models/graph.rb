class Graph < Struct.new(:nodes, :edges, :start_nodes, :end_nodes)
  def add_node(node)
    nodes << node
  end

  def delete_node(node)
    nodes.delete(node)
  end

  def add_edge(edge)
    edges << edge
  end

  def delete_edge(edge)
    edges.delete(edge)
  end

  def add_node(node)
    nodes << node
  end

  def delete_node(node)
    nodes.delete(node)
  end

  def add_start_node(node)
    start_nodes << node
  end

  def delete_start_node(node)
    start_node.delete(node)
  end

  def add_end_node(node)
    end_nodes << node
  end

  def delete_end_node(node)
    end_nodes.delete(node)
  end
end
