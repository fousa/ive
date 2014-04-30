require "xcoder"

module Ive
  class Base
      def list
        puts "-- Ive supports the following version bumps:"
        puts "- major"
        puts "- minor"
        puts "- patch"
        puts "- build"
      end

      def bump(type, git=false)
        fetch_config do |config|
          if git
            if Git.changes?
              puts "-- This repository has uncommited changes please commit these changes before performing a version bump."
            else
              version = Bump.public_send(type, config)
              Git.commit version
            end
          else
            Bump.public_send(type, config)
          end
        end
      end

      def version
        fetch_config do |config|
          puts "-- Version #{config.info_plist.marketing_version}"
          puts "-- Build version #{config.info_plist.version}"
        end
      end

      private

      def fetch_config &block
        xcode = Ive::Xcode.new
        if config = xcode.config
          yield config if block_given?
        elsif xcode
          puts "-- .ive configuration file missing or invalid."
        else
          puts "-- No project file found"
        end
      end
    end
end
