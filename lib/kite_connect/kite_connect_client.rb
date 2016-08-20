require "addressable/uri"
require "digest"
require "unirest"

class KiteConnectClient
  attr_reader :api_key, :token

  def initialize api_key
    @api_key = api_key
  end

  def login_url
    path = Endpoints.url Endpoints::LOGIN
    uri = Addressable::URI.new
    uri.query_values = {api_key: @api_key}
    "#{path}?#{uri.query}"
  end

  def request_access_token request_token, api_secret
    checksum = Digest::SHA256.digest "#{@api_key}#{request_token}#{api_secret}"
    params = {api_key: @api_key, request_token: request_token, checksum: checksum}
    response = Unirest.post Endpoints.url(Endpoints::TOKEN), parameters: params
    if response.code == 200 && response.body['status'] === KiteResponse::SUCCESS
      @token = Token.new response.body['data']
    else
      raise RuntimeError, response.body.inspect
    end
    @token
  end

  def logout
    params = {api_key: @api_key, access_token: @token.access_token}
    response = Unirest.delete Endpoints.url(Endpoints::LOGOUT), parameters: params
    if response.code == 200
      @token = nil
    else
      raise RuntimeError, "Failed to logout. Response #{response.body}"
    end
  end
end
