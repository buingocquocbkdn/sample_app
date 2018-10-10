
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sample_app/version"

Gem::Specification.new do |spec|
  spec.name          = "sample_app"
  spec.version       = SampleApp::VERSION
  spec.authors       = ["TODO: Write your name"]
  spec.email         = ["buingocquocbkdn@gmail.com"]
  spec.summary       = %q(TODO: Write a shortbecause RubyGemsrequiresone.)
  spec.description   = %q(TODO: Write a longer descriptionordelete this line.)
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject{|f| f.match(%r{^(test|spec|features)/})}
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}){|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
