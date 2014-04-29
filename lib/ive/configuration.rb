require "ostruct"
require "yaml"

module Ive
  class Configuration
    attr :target
    attr :configuration

    def initialize
      if self.exists?
        self.read_config
        unless self.valid?
          puts "-- Invalid .ive config file."
        end
      else
        puts "-- No .ive config file found."
      end
    end

    def read_config
      params = YAML::load File.open(self.config_path)
      @target = params["target"]
      @configuration = params["configuration"]
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
