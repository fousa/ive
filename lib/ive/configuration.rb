require "ostruct"
require "yaml"

module Ive
  class Configuration
    attr :target
    attr :configuration

    def initialize
      self.read_config if self.exists?
    end

    def create_file xcode_params
      File.open(config_path, "w") { |f| f.write(initial_content(xcode_params)) } unless exists?
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

    def initial_content xcode_params
      <<TEXT
target: "#{xcode_params[:target]}"
configuration: "#{xcode_params[:configuration]}"
TEXT
    end
  end
end
