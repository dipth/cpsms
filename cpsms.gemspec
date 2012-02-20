# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cpsms/version"

Gem::Specification.new do |s|
  s.name        = "cpsms"
  s.version     = CPSMS::VERSION
  s.authors     = ["dipth"]
  s.email       = ["thomas@dippel.dk"]
  s.homepage    = "https://github.com/dipth/cpsms"
  s.summary     = %q{Wrapper for the cpsms.dk API}
  s.description = %q{Wrapper for the cpsms.dk API}

  s.rubyforge_project = "cpsms"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
