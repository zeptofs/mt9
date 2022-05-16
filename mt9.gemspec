# frozen_string_literal: true

require_relative "lib/mt9/version"

Gem::Specification.new do |spec|
  spec.name = "mt9"
  spec.version = MT9::VERSION
  spec.authors = ["Zepto"]
  spec.email = ["engineering@zepto.com.au"]

  spec.summary =
    "MT9 is a data standard used within the NZ banking industry for the creation of Bulk Payments and Receipts."
  spec.homepage = "https://github.com/zeptofs/mt9"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-validation", "~> 1.8.0"

  spec.add_development_dependency "pry-byebug", "~> 3.9.0"
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
