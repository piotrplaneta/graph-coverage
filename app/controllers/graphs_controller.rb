require_relative "../adapters/form_adapter"
require_relative "../presenters/text/test_presenter"

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
    graph = Adapters::FormAdapter.graph_from(params)
    test = graph.coverage_strategy.covering_test
    if test
      text_of_test = Presenters::Text::TestPresenter.present(test)
    else
      text_of_test = "No test found, validate your graph."
    end
    erb :coverage, :locals => { :text_of_test => text_of_test }
  end
end
