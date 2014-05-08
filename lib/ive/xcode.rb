require "xcoder"

module Ive
  class Xcode
    def config
      return nil unless Ive.config.valid?

      target = ENV["IVE_TARGET"] || Ive.config.targets.first
      contains_target = !project.targets.detect { |t| t.name == target }.nil?
      puts "-- Target '#{target}' not found in the project." unless contains_target

      configuration = ENV["IVE_CONFIGURATION"] || Ive.config.configurations[target].first
      project_target = project.target(target)
      contains_configuration = !project_target.configs.detect { |c| c.name == configuration }.nil?
      puts "-- Configuration '#{configuration}' not found for Target '#{target}' in the project." unless contains_configuration

      project_configuration = project_target.config(configuration)
      puts "-- Used the '#{target}' Target with the '#{configuration}' configuration."
      project_configuration
    rescue Exception => e
      puts "-- #{e.message}" unless e.class == NoMethodError
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
