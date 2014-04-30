require "xcoder"

module Ive
  class Base
      def list
        puts "Ive supports the following version bumps:"
        puts "- major"
        puts "- minor"
        puts "- patch"
        puts "- build"
      end

      def bump(type, git=false)
        fetch_config do |config|
          use_git git do
            if git
              version = Bump.public_send(type, config)
              Git.commit version
            else
              Bump.public_send(type, config)
            end
          end
        end
      end

      def initialize_version git=false
        fetch_config do |config|
          use_git git do
            if git
              version = Bump.initialize_version config
              Git.commit version
            else
              Bump.initialize_version config
            end
          end
        end
      end

      def version
        fetch_config do |config|
          puts "-- Current version #{config.info_plist.marketing_version}"
          puts "-- Current build version #{config.info_plist.version}"
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
          puts "-- No project file found."
        end
      end

      def use_git enabled, &block
        if enabled
          if Git.changes?
            puts "-- This repository has uncommited changes please commit these changes before performing a version bump."
          else
            yield if block_given?
          end
        else
          yield if block_given?
        end
      end
    end
end
