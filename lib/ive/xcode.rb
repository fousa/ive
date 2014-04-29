require "xcoder"

module Ive
  class Xcode
    def config
      return nil unless Ive.config.valid?

      project.target(Ive.config.target).config(Ive.config.configuration)
    #rescue Exception => e
      #nil
    end

    def project
      @project ||= ::Xcode.project self.project_path
    end

    def project_path
      @project_path ||= Dir.glob("#{Ive.path}/*.xcodeproj").first
    end
  end
end
