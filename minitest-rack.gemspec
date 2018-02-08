
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "minitest/rack/version"

Gem::Specification.new do |spec|
  spec.name          = "minitest-rack"
  spec.version       = Minitest::Rack::VERSION
  spec.authors       = ["Kematzy"]
  spec.email         = ["kematzy@gmail.com"]

  spec.summary       = %q{Minitest & rack-test convenience assertions/expectations for DRY'er faster testing.}
  spec.description   = %q{Save time and energy by writing short effecient obvious assertions/expectations with Rack-test when using Minitest.}
  spec.homepage      = "https://github.com/kematzy/minitest-rack"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
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

  spec.add_dependency "minitest", "~> 5.0"
  spec.add_dependency "rack-test"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "rubocop"
end
