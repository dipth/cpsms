require(File.expand_path('./../../../spec_helper', __FILE__))
require 'mocha'

describe CPSMS::SMS do

  let(:username)  { ENV.fetch('CPSMS_USERNAME', 'fake-cpsms-username') }
  let(:password)  { ENV.fetch('CPSMS_PASSWORD', 'fake-cpsms-password') }
  let(:recipient) { ENV.fetch('CPSMS_MOBILE_NUMBER', 'fake-cpsms-mobile-number') }

  describe "default attributes" do
    it "must include httparty methods" do
      CPSMS::SMS.must_include HTTParty
    end

    it "must have the base url set to the CPSMS API endpoint" do
      CPSMS::SMS.base_uri.must_equal 'https://www.cpsms.dk'
    end
  end

  describe ".send!" do
    before do
      VCR.insert_cassette 'sms',
                          :record => :new_episodes,
                          :match_requests_on => [:method, :body]
    end
    after  { VCR.eject_cassette }

    it "must have a send! method" do
      CPSMS::SMS.must_respond_to :send!
    end

    it "passes on the from option to the API" do
      CPSMS::SMS.expects(:parse_response) { nil }
      CPSMS::SMS.expects(:post).with() do |path, options|
        options[:body][:from] == "foobar"
      end.returns( stub(:body) )
      CPSMS::SMS.send!(username, password, recipient, "test", { :from => "foobar" })
    end

    it "passes on the utf8 option to the API" do
      CPSMS::SMS.expects(:parse_response) { nil }
      CPSMS::SMS.expects(:post).with() do |path, options|
        options[:body][:utf8] == "1"
      end.returns( stub(:body) )
      CPSMS::SMS.send!(username, password, recipient, "test", { :utf8 => true })
    end

    describe "with invalid credentials" do
      it "raises a CPSMS::InvalidCredentialsError" do
        proc do
          CPSMS::SMS.send!("wrong", "wrong", recipient, "test")
        end.must_raise CPSMS::InvalidCredentialsError
      end
    end

    describe "with valid credentials" do
      describe "and invalid recipient" do
        it "raises a CPSMS::InvalidRecipientError" do
          proc do
            CPSMS::SMS.send!(username, password, 12345678, "test")
          end.must_raise CPSMS::InvalidRecipientError
        end
      end

      describe "and a valid recipient" do
        it "returns true" do
          CPSMS::SMS.send!(username, password, recipient, "test").must_equal true
        end
      end
    end
  end

end
