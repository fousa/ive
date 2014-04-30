require "xcoder"

module Ive
  class Xcode
    def config
      return nil unless Ive.config.valid?

      project.target(Ive.config.target).config(Ive.config.configuration)
    rescue Exception => e
      puts "-- #{e.message}"
      nil
    end

    def initial_config
      if project.targets.count > 0 && (target = project.targets.first)
        if target.configs.count > 0 && (config = target.configs.first)
          { target: target.name, configuration: config.name }
        else
          puts "-- No configurations found for target '#{target.name}' in the current project"
        end
      else
        puts "-- No targets found in the current project"
      end
    end

    def project
      @project ||= ::Xcode.project self.project_path
    end

    def project_path
      @project_path ||= Dir.glob("#{Ive.path}/*.xcodeproj").first
    end
  end
end
