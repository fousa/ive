require "xcoder"
require "yaml"

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
        path = Dir.pwd unless path
        puts "-- Using the current project: #{path}"

        if project = xcode_project(path)
          config = config project, path
          return if config.nil?

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
          config = config project, path
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

      def config project, path
        if config_file?(path) && valid_config?(path)
          config = config_file path
          project.target(config["target"]).config(config["configuration"])
        else
          project.targets.first.config(:Debug)
        end
      rescue Exception => e
        puts "-- #{e}"
        nil
      end

      def config_file? path
        File.exists?(File.join(path,'.ive'))
      end

      def config_file path
        YAML::load(File.open(File.join(path,'.ive')))
      end

      def valid_config? path
        config = config_file path
        config["target"] && config["configuration"]
      end
    end
  end
end
