class Node < Struct.new(:id)
  def neighbours(graph_edges)
    node_edges(graph_edges).collect { |edge| edge.destination }
  end

  def to_s
    id.to_s
  end

  private
  def node_edges(graph_edges)
    graph_edges.select { |edge| edge.source == self }
  end
end
