require_relative "generic_adapter"

module GraphAdapters
  class FileAdapter < Struct.new(:filename)
    SECTIONS_COUNT_WITHOUT_DATA_FLOW = 4
    SECTIONS_COUNT_WITH_DATA_FLOW = 6

    attr_accessor :sections

    def self.graph_from(filename)
      new(filename).graph
    end

    def graph
      GenericAdapter.graph_from(params_from_file)
    end

    private
    def params_from_file
      self.sections = file_content.split("-")
      if ![SECTIONS_COUNT_WITHOUT_DATA_FLOW, SECTIONS_COUNT_WITH_DATA_FLOW].
        include?(sections.count)

        raise ArgumentError.new("Wrong file")
      end

      params_from_sections
    end

    def file_content
      File.read("public/uploads/#{filename}")
    end

    def params_from_sections
      if data_flow_params
        default_params_from_sections.merge(data_flow_params)
      else
        default_params_from_sections.merge(coverage_type_param_from_sections)
      end
    end

    def data_flow_params
      return nil if !(sections.count == SECTIONS_COUNT_WITH_DATA_FLOW)
      {
        :def_nodes => sections[3],
        :use_nodes => sections[4],
        :coverage_type => sections[5],
      }
    end

    def coverage_type_param_from_sections
      { :coverage_type => sections[3] }
    end

    def default_params_from_sections
      {
        :edges => sections[0],
        :start_nodes => sections[1],
        :end_nodes => sections[2],
      }
    end
  end
end
