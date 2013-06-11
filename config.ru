require "rubygems"
require "bundler"

Bundler.require

require "./app/controllers/graphs_controller"

run GraphsController
