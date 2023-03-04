$:.push File.expand_path("../lib", __FILE__)
require "turbo_editable/version"

Gem::Specification.new do |s|
  s.name        = "turbo_editable"
  s.version     = TurboEditable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grigory"]
  s.email       = ["mail@grigor.io"]
  s.homepage    = "http://github.com/gryphon/turbo_editable"
  s.summary     = %q{In-place editor for Turbo}
  s.description = %q{In-place editor for Turbo}
  
  #s.files         = `git ls-files`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = Dir['assets/**/*']
  
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 7.0"

end