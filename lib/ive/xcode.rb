require "xcoder"

module Ive
  class Xcode
    def config
      return nil unless Ive.config.valid?

      target = Ive.config.targets.first
      configuration = Ive.config.configurations[target].first
      puts "-- Used the '#{target}' Target with the '#{configuration}' configuration."
      project.target(target).config(configuration)
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
