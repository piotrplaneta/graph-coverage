module Uploaders
  class FileUploader < Struct.new(:params)
    include FileUtils::Verbose

    def self.upload!(params)
      new(params).perform!
    end

    def perform!
      tempfile = params[:file][:tempfile]
      filename = params[:file][:filename] + Time.now.to_i.to_s
      cp(tempfile.path, "public/uploads/#{filename}")
      filename
    end
  end
end
