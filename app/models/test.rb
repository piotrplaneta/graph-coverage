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

  def valid_on?(graph)
    validation_results = paths.collect do |path|
      graph.validate_start_and_end(path) && graph.validate(path)
    end

    validation_results.inject(true) { |memo, result| memo && result }
  end
end
