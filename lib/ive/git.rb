require "git"

module Ive
  class Git
    class << self
      def changes?
        git = ::Git.open Ive.path
        git.status.changed.count > 0
      end

      def commit version
        git = ::Git.open Ive.path
        git.add all: true
        git.commit "Version bump"
        git.add_tag version
      end
    end
  end
end
