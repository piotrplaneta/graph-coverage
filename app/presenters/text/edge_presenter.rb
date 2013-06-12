module Presenters
  module Text
    class EdgePresenter < Struct.new(:edge)
      def self.present(edge)
        new(edge).to_text
      end

      def to_text
        edge.source.to_s + " -> " + edge.destination.to_s
      end
    end
  end
end
