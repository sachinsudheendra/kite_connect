require "addressable/uri"
require "digest"
require "unirest"

class KiteConnectClient
  attr_reader :api_key, :token
  include Client::Session
  include Client::User
  include Client::Orders

  def initialize api_key
    @api_key = api_key
  end

  def default_params
    {api_key: @api_key, access_token: @token.access_token}
  end

  private

  def fail response
    raise RuntimeError, "[ERROR] Request failed. Response #{response.body}"
  end
end
