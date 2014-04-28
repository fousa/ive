require "git"

module Ive
  class Git
    class << self
      def changes? path
        git = ::Git.open path
        git.status.changed.count > 0
      end

      def commit path, version
        git = ::Git.open path
        git.add all: true
        git.commit "Version bump"
        git.add_tag version
      end
    end
  end
end
