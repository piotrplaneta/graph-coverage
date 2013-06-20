require_relative "../graph_adapters/form_adapter"
require_relative "../graph_adapters/file_adapter"
require_relative "../uploaders/file_uploader"
require_relative "../helpers/coverage_helper"

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

    render_coverage(graph, params[:format])
  end

  post "/coverage-file" do
    filename = Uploaders::FileUploader.upload!(params)
    graph = GraphAdapters::FileAdapter.graph_from(filename)

    render_coverage(graph, params[:format])
  end

  private
  def render_coverage(graph, format)
    erb :coverage, :locals => Helpers::CoverageHelper.new(graph, format).locals
  end
end
