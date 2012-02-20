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

  s.add_dependency('httparty',      '~> 0.8.1')

  case s.platform.to_s
  when 'ruby'
    s.add_dependency('libxml-ruby',   '~> 2.2.2')
  when 'jruby'
    s.add_dependency('libxml-jruby',  '~> 1.0.0')
    s.add_dependency('jruby-openssl', '~> 0.7.6')
  end

  s.add_development_dependency('minitest',       '~> 2.11.2')
  s.add_development_dependency('webmock',        '~> 1.7.10')
  s.add_development_dependency('vcr',            '~> 2.0.0.rc1')
  s.add_development_dependency('turn',           '~> 0.9.3')
  s.add_development_dependency('rake',           '~> 0.9.2')
  s.add_development_dependency('guard-minitest', '~> 0.4.0')
end
