require "rubygems"
require "bundler/setup"
require "pry"

require_relative "../app/models/node.rb"
require_relative "../app/models/edge.rb"
require_relative "../app/models/path.rb"

require_relative "../app/models/test.rb"
require_relative "../app/models/graph.rb"

require_relative "../app/models/coverage_strategies/node_coverage.rb"
require_relative "../app/models/coverage_strategies/edge_coverage.rb"
require_relative "../app/models/coverage_strategies/edge_pair_coverage.rb"
require_relative "../app/models/coverage_strategies/prime_coverage.rb"
require_relative "../app/models/coverage_strategies/all_defs_coverage.rb"
require_relative "../app/models/coverage_strategies/all_uses_coverage.rb"

require_relative "../app/graph_adapters/generic_adapter"
require_relative "../app/graph_adapters/file_adapter"

require_relative "../app/presenters/text/edge_presenter.rb"
require_relative "../app/presenters/text/path_presenter.rb"
require_relative "../app/presenters/text/graph_presenter.rb"
require_relative "../app/presenters/text/test_presenter.rb"

require_relative "../app/presenters/json/edges_presenter.rb"

require_relative "../app/helpers/coverage_helper.rb"


RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
