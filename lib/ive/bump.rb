require "versionomy"

module Ive
  class Bump
    class << self
      def major(config, with_git=false)
        puts "-- Bumping version"
        bumped_version config, :major
      end

      def minor(config, with_git=false)
        puts "-- Bumping version"
        bumped_version config, :minor
      end

      def patch(config, with_git=false)
        puts "-- Bumping version"
        bumped_version config, :tiny
      end

      def build(config, with_git=false)
        puts "-- Bumping build version"
      end

      private
      
      def bumped_version config, type
        version = Versionomy.parse config.info_plist.marketing_version
        config.info_plist do |info|
          info.marketing_version = version.bump(type).to_s
          info.version = build_version_from info.marketing_version
          info.save
        end

        new_version = "v#{config.info_plist.marketing_version}"
        puts "-- New version: #{config.info_plist.marketing_version}"
        puts "-- New build version: #{config.info_plist.version}"
        new_version
      end

      def build_version_from version
        version.gsub(".", "") + ".0001"
      end
    end
  end
end
