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
  c.hook_into :webmock
  c.filter_sensitive_data('username=<USERNAME>')       { "username=#{ ENV.fetch('CPSMS_USERNAME', 'fake-cpsms-username') }" }
  c.filter_sensitive_data('password=<PASSWORD>')       { "password=#{ ENV.fetch('CPSMS_PASSWORD', 'fake-cpsms-password') }" }
  c.filter_sensitive_data('recipient=<MOBILE_NUMBER>') { "recipient=#{ ENV.fetch('CPSMS_MOBILE_NUMBER', 'fake-cpsms-mobile-number') }" }

  # Since HTTParty takes a Hash of body data, we can never be sure that it is
  # sent in the same order. This can cause VCR to not recognise the request and
  # therefore not use a previously recorded response.
  # This overrides VCR's built-in :body matcher to ignore the order of the data
  c.register_request_matcher :body do |request1, request2|
    body1 = request1.body.split('&')
    body2 = request2.body.split('&')
    (body1 - body2).empty?
  end
end
