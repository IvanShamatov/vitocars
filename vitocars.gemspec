# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vitocars/version'

Gem::Specification.new do |spec|
  spec.name          = "vitocars"
  spec.version       = Vitocars::VERSION
  spec.authors       = ["Ivan Shamatov"]
  spec.email         = ["status.enable@gmail.com"]

  spec.summary       = %q{Ruby wrapper around Vitocars API.}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/IvanShamatov/vitocars"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
