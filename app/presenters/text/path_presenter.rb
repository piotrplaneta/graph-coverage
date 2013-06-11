module Presenters
  module Text
    class PathPresenter < Struct.new(:path)
      def self.present(path)
        new(path).to_text
      end

      def to_text
        path.nodes.join(" -> ")
      end
    end
  end
end
