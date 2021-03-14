require_relative "lib/log_parser/version"

Gem::Specification.new do |spec|
  spec.name = "log_parser"
  spec.version = LogParser::VERSION
  spec.authors = ["Felipe G. Hespanhol"]
  spec.email = ["felipeghespanhol@gmail.com"]

  spec.summary = "Parse page view logs and extract reports from them"
  spec.homepage = "https://github.com/felipehespanhol/log_parser"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/felipehespanhol/log_parser"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "standard", "~> 1.0"
  spec.add_development_dependency "pry", "~> 0.13"
end
