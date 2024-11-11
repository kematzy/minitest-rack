# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'minitest/rack/version'

Gem::Specification.new do |spec|
  spec.name          = 'minitest-rack'
  spec.version       = Minitest::Rack::VERSION
  spec.authors       = ['Kematzy']
  spec.email         = ['kematzy@gmail.com']

  spec.summary       = "Minitest & rack-test convenience assertions/expectations for DRY'er faster testing."
  spec.description   = 'Save time and energy by writing short effecient obvious assertions/expectations with rack/test'
  spec.homepage      = 'https://github.com/kematzy/minitest-rack'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.platform         = Gem::Platform::RUBY
  spec.extra_rdoc_files = ['README.md', 'LICENSE.txt']
  spec.rdoc_options += ['--quiet', '--line-numbers', '--inline-source', '--title',
                        'Minitest::Rack: rack-test convenience assertions', '--main', 'README.md']

  spec.add_dependency('json', '~> 2.8.1', '>= 2.8.0')
  spec.add_dependency('minitest', '~> 5.25.0', '>= 5.20.0')
  spec.add_dependency('rack-test', '~> 2.1.0', '>= 2.1.0')

  spec.metadata['rubygems_mfa_required'] = 'true'
end
