require "versionomy"

module Ive
  class Bump
    class << self
      def major(config)
        bumped_version config, :major
      end

      def minor(config)
        bumped_version config, :minor
      end

      def patch(config)
        bumped_version config, :tiny
      end

      def build(config)
        bumped_build_version config
      end

      private
      
      def bumped_version config, type
        version = Versionomy.parse config.info_plist.marketing_version
        config.info_plist do |info|
          info.marketing_version = version.bump(type).to_s
          info.version = build_version_from info.marketing_version, 1
          info.save
        end

        new_version = "v#{config.info_plist.marketing_version}"
        new_version
      end

      def bumped_build_version config
        version = Versionomy.parse config.info_plist.marketing_version
        config.info_plist do |info|
          new_build_version = extract_build_version info.version
          info.version = build_version_from info.marketing_version, new_build_version + 1
          info.save
        end
      end

      def build_version_from version, count
        version.gsub(".", "") + ".#{"%04.f" % count}"
      end

      def extract_build_version version
        version.split(".").last.to_i
      end
    end
  end
end
