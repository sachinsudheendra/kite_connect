class TestResponse
  class Response
    attr_accessor :code, :body

    def initialize code, body
      @code = code
      @body = body
    end
  end

  def self.success
    Response.new(200, {'status' => 'success'})
  end

  def self.error
    Response.new(400, {'status' => 'error'})
  end

  def self.token_success
    Response.new(200, {'status' => 'success', 'data' => {}})
  end

  def self.token_error
    Response.new(400, {'status' => 'error', 'data' => {}})
  end

  def self.margin_success
    data = {
      "enabled": true,
      "net": 1230.0,
      "available": {
        "cash": 1110.0,
        "intraday_payin": 230.0,
        "adhoc_margin": 3230.0,
        "collateral": 43240.0
      },
      "utilised": {
        "m2m_unrealised": 0.0,
        "m2m_realised": 0.0,
        "debits": 0.0,
        "span": 0.0,
        "option_premium": 1230.0,
        "holding_sales": 23330.0,
        "exposure": 23285.85,
        "turnover": 0.0
      }
    }
    Response.new(200, {'status' => 'success', 'data' => data})
  end
end
