require 'uri'

module Endpoints
  HOST = "api.kite.trade"
  LOGIN = "/connect/login"
  TOKEN = "/session/token"
  LOGOUT = "/session/token"
  EQUITY_MARGIN = "/user/margins/equity"
  COMMODITY_MARGIN = "/user/margins/commodity"
  ORDERS = "/orders"

  def self.url path
    params = {host: Endpoints::HOST, path: path}
    URI::HTTPS.build(params).to_s
  end
end
