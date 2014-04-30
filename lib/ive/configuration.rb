require "ostruct"
require "yaml"

module Ive
  class Configuration
    attr :target
    attr :configuration

    def initialize
      self.read_config if self.exists?
    end

    def read_config
      params = YAML::load File.open(self.config_path)
      if params
        @target = params["target"]
        @configuration = params["configuration"]
      end
    end

    def valid?
      @target && @configuration
    end

    def exists?
      File.exists?(self.config_path)
    end

    def config_path
      @config_path ||= File.join(Ive.path,'.ive')
    end
  end
end
