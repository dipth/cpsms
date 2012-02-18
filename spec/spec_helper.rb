#we need the actual library file
require(File.expand_path('../../lib/cpsms', __FILE__))

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # use humanized test names (works only with :outline format)
 c.natural = true
end

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cpsms_cassettes'
  c.stub_with :webmock
  c.filter_sensitive_data('username=<USERNAME>')       { "username=#{ ENV.fetch('CPSMS_USERNAME', 'fake-cpsms-username') }" }
  c.filter_sensitive_data('password=<PASSWORD>')       { "password=#{ ENV.fetch('CPSMS_PASSWORD', 'fake-cpsms-password') }" }
  c.filter_sensitive_data('recipient=<MOBILE_NUMBER>') { "recipient=#{ ENV.fetch('CPSMS_MOBILE_NUMBER', 'fake-cpsms-mobile-number') }" }
end
