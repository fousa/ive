# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ive/version'

Gem::Specification.new do |spec|
  spec.name          = "ive"
  spec.version       = Ive::VERSION
  spec.authors       = ["Jelle Vandebeeck"]
  spec.email         = ["jelle@fousa.be"]
  spec.summary       = %q{A gem that allows you to bump the version of your Xcode project.}
  spec.description   = %q{A gem that allows you to bump the version of your Xcode project. You can do a major, minor, patch or build bump. }
  spec.homepage      = "https://github.com/fousa/ive"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
