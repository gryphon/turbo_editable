require_relative "lib/turbo_editable/version"

Gem::Specification.new do |spec|
  spec.name        = "turbo_editable"
  spec.version     = TurboEditable::VERSION
  spec.authors     = [""]
  spec.email       = [""]
  spec.homepage    = "http://github.com/gryphon/turbo_editable"
  spec.summary     = "In-place editor for Turbo"
  spec.description = "In-place editor for Turbo"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0"
end
