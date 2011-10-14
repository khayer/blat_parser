# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blat_parser/version"

Gem::Specification.new do |s|
  s.name        = "blat_parser"
  s.version     = BlatParser::VERSION
  s.authors     = ["Kaharina Hayer"]
  s.email       = ["katharinaehayer@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This is a blat parser}
  s.description = %q{Build for runtime testing}

  s.rubyforge_project = "blat_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
