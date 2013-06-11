require_relative "../graph_adapters/form_adapter"
require_relative "../presenters/text/test_presenter"
require_relative "../uploaders/file_uploader"

class GraphsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }
  set :public_folder, Proc.new { File.join(root, "../../public") }

  get "/index" do
    erb :index
  end

  get "/data-flow" do
    erb :data_flow
  end

  post "/coverage" do
    graph = GraphAdapters::FormAdapter.graph_from(params)
    erb :coverage, :locals => { :text_of_test => text_of_test(graph) }
  end

  post "/coverage-file" do
    filename = Uploaders::FileUploader.upload(params)
    filename
  end

  def text_of_test(graph)
    test = graph.coverage_strategy.covering_test
    if test
      text_of_test = Presenters::Text::TestPresenter.present(test)
    else
      text_of_test = "No test found, validate your graph."
    end
  end
end
