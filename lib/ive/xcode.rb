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
      config_hash = {}
      project.targets.each do |target|
        if target.configs.count > 0
          config_hash[target.name] = target.configs.map(&:name)
        else
          puts "-- No configurations found for target '#{target.name}' in the current project"
        end
      end

      if config_hash.empty?
        puts "-- No targets found in the current project" 
        nil
      else
        config_hash
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
