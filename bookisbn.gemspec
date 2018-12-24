
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bookisbn/version"

Gem::Specification.new do |spec|
  spec.name          = "bookisbn"
  spec.version       = Bookisbn::VERSION
  spec.authors       = ["Huang Feilong"]
  spec.email         = ["huangfeilong@gmail.com"]

  spec.summary       = %q{Book ISBN Tool.}
  spec.description   = %q{Book ISNB Tool: validate, get ISBN ean.ucc, group, publisher, title and check digit.}
  spec.homepage      = "https://github.com/hfl/bookisbn"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
