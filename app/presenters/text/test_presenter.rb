require_relative "path_presenter.rb"

module Presenters
  module Text
    class TestPresenter < Struct.new(:test)
      def self.present(test)
        new(test).to_text
      end

      def to_text
        test.paths.map { |path| Presenters::Text::PathPresenter.present(path) }.
          join("<br />")
      end
    end
  end
end
