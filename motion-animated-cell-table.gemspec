# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "motion-animated-cell-table"
  spec.version       = "1.0"
  spec.authors       = ["Multunus"]
  spec.email         = ["info@multunus.com"]
  spec.summary       = %q{A RubyMotion library that facilitates the animation of cells tapped in a table}
  spec.description   = %q{This library makes it easy to give the illusion of popping a cell out and placing it back on cell tap}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
