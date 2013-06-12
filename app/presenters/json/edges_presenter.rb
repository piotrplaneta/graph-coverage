require "json"

module Presenters
  module Json
    class EdgesPresenter < Struct.new(:edges)
      def self.present(edges)
        new(edges).to_json
      end

      def to_json
        edges.to_json
      end
    end
  end
end
