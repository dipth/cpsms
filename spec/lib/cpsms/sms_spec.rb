require(File.expand_path('./../../../spec_helper', __FILE__))

describe CPSMS::SMS do

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

    describe "with invalid credentials" do
      it "raises a CPSMS::InvalidCredentialsError" do
        proc do
          CPSMS::SMS.send!("wrong", "wrong", 12345678)
        end.must_raise CPSMS::InvalidCredentialsError
      end
    end

    describe "with valid credentials" do
      describe "and invalid recipient" do
        it "raises a CPSMS::InvalidRecipientError" do
          proc do
            CPSMS::SMS.send!(ENV['CPSMS_USERNAME'], ENV['CPSMS_PASSWORD'], 12345678)
          end.must_raise CPSMS::InvalidRecipientError
        end
      end
    end
  end

end
