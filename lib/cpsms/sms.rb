module CPSMS
  require 'xml'

  class SMS

    include HTTParty

    base_uri 'https://www.cpsms.dk'

    def self.send!(username, password, recipient, message, options = {})
      body = { :username => username,
               :password => password,
               :recipient => recipient,
               :message => message }

      body[:from] = options[:from] if options[:from]
      body[:utf8] = 1 if options[:utf8] == true

      parse_response self.post('/sms/', :body => body).body
    end

  private

    def self.parse_response(response)
      xml = XML::Parser.string(response).parse

      error = xml.find_first('//error')
      self.handle_errors(error.content) if error

      success = xml.find_first('//succes') # cpsms.dk don't know how to spell
      self.handle_success(success.content) if success
    end

    def self.handle_errors(error)
      case error
      when 'Invalid username/password'
        raise InvalidCredentialsError
      end
    end

    def self.handle_success(success)
      case success
      when 'SMS succesfully sent to 0 recipient(s)'
        raise InvalidRecipientError
      when 'SMS succesfully sent to 1 recipient(s)'
        true
      end
    end

  end

  class InvalidCredentialsError < StandardError; end
  class InvalidRecipientError < StandardError; end
end
