require_relative "../app/models/node.rb"
require_relative "../app/models/edge.rb"
require_relative "../app/models/path.rb"

require_relative "../app/models/test.rb"
require_relative "../app/models/graph.rb"

require_relative "../app/models/decorators/node_coverage.rb"
require "pry"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
