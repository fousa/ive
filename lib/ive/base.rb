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
    end
  end
end
