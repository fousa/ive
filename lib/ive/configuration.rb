require "ostruct"
require "yaml"

module Ive
  class Configuration
    attr :targets
    attr :configurations

    def initialize
      self.read_config if self.exists?
    end

    def create_file xcode_params
      File.open(config_path, "w") { |f| f.write(initial_content(xcode_params)) } unless exists?
    end

    def read_config
      params = YAML::load File.open(self.config_path)
      if params
        @targets = params.keys
        @configurations = params
      end
    end

    def valid?
      return false unless @targets 
      return false unless @targets.count > 0 
      return false unless @configurations 
      values = @configurations.values.select { |v| v.count > 0 }
      return false if values.empty?
      true
    end

    def exists?
      File.exists?(self.config_path)
    end

    def config_path
      @config_path ||= File.join(Ive.path,'.ive')
    end

    def initial_content xcode_params
      xcode_params.to_yaml
    end
  end
end
