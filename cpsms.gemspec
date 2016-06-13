# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'cpsms/version'

Gem::Specification.new do |s|
  s.name        = 'cpsms'
  s.version     = CPSMS::VERSION
  s.authors     = ['dipth']
  s.email       = ['thomas@dippel.dk']
  s.homepage    = 'https://github.com/dipth/cpsms'
  s.summary     = 'Wrapper for the cpsms.dk API'
  s.description = 'Wrapper for the cpsms.dk API'

  s.rubyforge_project = 'cpsms'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency('httparty', '>= 0.10.2')

  case RUBY_PLATFORM
  when 'java'
    s.add_dependency('libxml-jruby',  '>= 1.0.0')
    s.add_dependency('jruby-openssl', '>= 0.7.6')
  else
    s.add_dependency('libxml-ruby',   '>= 2.6.0')
  end

  s.add_development_dependency('minitest',       '~> 2.11.2')
  s.add_development_dependency('webmock',        '~> 1.20.4')
  s.add_development_dependency('vcr',            '~> 2.9.3')
  s.add_development_dependency('turn',           '~> 0.9.3')
  s.add_development_dependency('rake',           '~> 0.9.2')
  s.add_development_dependency('guard-minitest', '~> 0.4.0')
  s.add_development_dependency('mocha',          '~> 0.10.5')
end
