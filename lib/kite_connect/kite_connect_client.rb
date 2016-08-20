require 'uri'
require "addressable/uri"

class KiteConnectClient
  @@DOMAIN = "api.kite.trade"

  attr_accessor :api_key, :access_token

  def initialize api_key, access_token
    self.api_key = api_key
    self.access_token = access_token
  end

  def login_url
    uri = Addressable::URI.new
    uri.query_values = {api_key: self.api_key}
    URI::HTTPS.build({host: @@DOMAIN, path: Endpoints::LOGIN, query: uri.query}).to_s
  end
end
