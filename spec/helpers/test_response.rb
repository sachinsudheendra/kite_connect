class TestResponse
  class Response
    attr_accessor :code, :body

    def initialize code, body
      @code = code
      @body = body
    end
  end

  def self.success
    Response.new(200, {})
  end

  def self.error
    Response.new(400, {})
  end

  def self.token_success
    Response.new(200, {'status' => 'success', 'data' => {}})
  end

  def self.token_error
    Response.new(400, {'status' => 'error', 'data' => {}})
  end
end
