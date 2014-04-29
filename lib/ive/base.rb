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
        if config = Ive::Xcode.new.config
          if git
            if Git.changes?
              puts "-- This repository has uncommited changes please commit these changes before performing a version bump."
            else
              if version = Bump.public_send(type, config)
                Git.commit version
              else
                puts "-- The current version is invalid, initialize the version."
              end
            end
          else
            unless version = Bump.public_send(type, config)
              puts "-- The current version is invalid, initialize the version."
            end
          end
        else
          puts "-- No project file found"
        end
      end

      def version
        if config = Ive::Xcode.new.config
          puts "-- Version #{config.info_plist.marketing_version}"
          puts "-- Build version #{config.info_plist.version}"
        else
          puts "-- No project file found"
        end
      end
    end
end
