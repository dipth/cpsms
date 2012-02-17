require "httparty"
Dir[File.dirname(__FILE__) + '/cpsms/*.rb'].each do |file|
  require file
end
