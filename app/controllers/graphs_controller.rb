require_relative "../graph_adapters/form_adapter"
require_relative "../presenters/text/test_presenter"
require_relative "../presenters/text/graph_presenter"
require_relative "../uploaders/file_uploader"

class GraphsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }
  set :public_folder, Proc.new { File.join(root, "../../public") }

  get "/" do
    erb :index
  end

  get "/data-flow" do
    erb :data_flow
  end

  post "/coverage" do
    graph = GraphAdapters::FormAdapter.graph_from(params)

    erb :coverage, :locals => {
      :text_of_test => text_of_test_for(graph),
      :text_of_graph => Presenters::Text::GraphPresenter.present(graph)
    }
  end

  post "/coverage-file" do
    filename = Uploaders::FileUploader.upload(params)
    graph = GraphAdapters::FileAdapter.graph_from(filename)

    erb :coverage, :locals => {
      :text_of_test => text_of_test_for(graph),
      :text_of_graph => Presenters::Text::GraphPresenter.present(graph)
    }
  end

  def text_of_test_for(graph)
    test = graph.coverage_strategy.covering_test
    if test
      text_of_test = Presenters::Text::TestPresenter.present(test)
    else
      text_of_test = "No test found, validate your graph."
    end
  end
end
