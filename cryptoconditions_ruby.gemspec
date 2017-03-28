# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cryptoconditions_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "cryptoconditions_ruby"
  spec.version       = CryptoconditionsRuby::VERSION
  spec.authors       = ["Adam Groves"]
  spec.email         = ["adam.groves@gmail.com"]

  spec.summary       = %q{Cryptoconditions for Ruby}
  spec.description   = %q{Cryptoconditions gem based on the python cryptoconditions library}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rbnacl', '~> 4.0.1'
  spec.add_runtime_dependency 'base32', '~> 0.3.2'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "rubocop", "~> 0.48"
end
