require "ive/version"
require "ive/base"
require "ive/bump"
require "ive/git"
require "ive/configuration"
require "ive/xcode"

module Ive
  class << self
    def config
      @config ||= Configuration.new
    end

    def path
      ENV["IVE_PATH"] || Dir.pwd
    end
  end
end
