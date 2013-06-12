require_relative "../presenters/text/test_presenter"
require_relative "../presenters/text/graph_presenter"
require_relative "../presenters/json/edges_presenter"

module Helpers
  class CoverageHelper < Struct.new(:graph, :format)
    def locals
      locals = default_locals_for_coverage_of_graph
      with_json_edges(locals)
    end

    private
    def with_json_edges(locals)
      if format == "json"
        locals.merge({ :edges_json => edges_json })
      else
        locals.merge({ :edges_json => nil })
      end
    end

    def default_locals_for_coverage_of_graph
      {
        :text_of_test => test_text,
        :text_of_graph => graph_text
      }
    end

    def edges_json
      Presenters::Json::EdgesPresenter.present(graph.edges)
    end

    def graph_text
      Presenters::Text::GraphPresenter.present(graph)
    end

    def test_text
      if test
        text_of_test = Presenters::Text::TestPresenter.present(test)
      else
        text_of_test = "No test found, validate your graph."
      end
    end

    def test
      graph.coverage_strategy.covering_test
    end
  end
end
