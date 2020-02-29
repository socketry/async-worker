
require_relative "lib/async/worker/version"

Gem::Specification.new do |spec|
	spec.name = "async-worker"
	spec.version = Async::Worker::VERSION
	spec.authors = ["Samuel Williams"]
	spec.email = ["samuel.williams@oriontransfer.co.nz"]

	spec.summary = "Non-blocking thread-pool based workers for blocking operations."
	spec.homepage = "https://github.com/socketry/async-worker"

	spec.files = `git ls-files`.split($/)
	spec.executables = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
	spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_dependency 'async', '~> 1.0'
	spec.add_dependency 'async-io', '~> 1.3'
	
	spec.add_development_dependency "async-rspec", "~> 1.0"
	
	spec.add_development_dependency "covered"
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rake", "~> 12.3"
	spec.add_development_dependency "rspec", "~> 3.0"
end
