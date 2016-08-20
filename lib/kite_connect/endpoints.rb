require 'uri'

module Endpoints
  HOST = "api.kite.trade"
  LOGIN = "/connect/login"
  TOKEN = "/session/token"
  LOGOUT = "/session/token"

  def self.url path
    params = {host: Endpoints::HOST, path: path}
    URI::HTTPS.build(params).to_s
  end
end
