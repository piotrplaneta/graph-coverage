class Test < Struct.new(:paths)
  def initialize(paths = [])
    self.paths = paths
  end

  def add_path(path)
    paths << path
  end

  def delete_path(path)
    paths.delete(path)
  end
end
