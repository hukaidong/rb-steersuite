# frozen_string_literal: true

require_relative "lib/steersuite/version"

Gem::Specification.new do |spec|
  spec.name          = "steersuite"
  spec.version       = Steersuite::VERSION
  spec.authors       = ["Kaidong Hu"]
  spec.email         = ["hukaidonghkd@gmail.com"]

  spec.summary       = "A Ruby processor for SteerSuite simulation results"
  spec.description   = "A Ruby processor for SteerSuite simulation results"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{\A(?:test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "tqdm", "~> 0.4"
  spec.add_dependency "numo-gnuplot", "~> 0.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
