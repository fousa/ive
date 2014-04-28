require "xcoder"

module Ive
  class Base
    class << self
      def list
        puts "-- Ive supports the following version bumps:"
        puts "- major"
        puts "- minor"
        puts "- patch"
        puts "- build"
      end

      def bump(type, path, with_git=false)
        puts "-- Using the current project: #{path}"
        if project = xcode_project(path)
          config = project.targets.first.config(:Debug)

          puts "-- Tagging and commiting enabled: #{with_git ? "yes" : "no"}"
          if with_git
            if Git.changes?(path)
              puts "-- This repository has uncommited changes please commit these changes before performing a version bump."
              return
            else
              Git.commit path, Ive::Bump.public_send(type, config, with_git)
            end
          else
            Ive::Bump.public_send type, config, with_git
          end
        else
          puts "-- No project file found"
        end
      end

      def version path
        puts "-- Using the current project: #{path}"
        if project = xcode_project(path)
          config = project.targets.first.config(:Debug)
          puts "-- Version #{config.info_plist.marketing_version}"
          puts "-- Build version #{config.info_plist.version}"
        else
          puts "-- No project file found"
        end
      end

      private

      def xcode_project path
        project_path = Dir.glob("#{path}/*.xcodeproj").first
        Xcode.project project_path
      end
    end
  end
end
