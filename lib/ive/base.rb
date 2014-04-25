module Ive
  class Base
    class << self
      def list
        puts "Ive supports the following version bumps:"
        puts "- major"
        puts "- minor"
        puts "- patch"
        puts "- build"
      end

      def bump(type, with_git=false)
      end
    end
  end
end
