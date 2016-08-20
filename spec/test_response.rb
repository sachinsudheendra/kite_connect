class TestResponse
  attr_accessor :code, :body

  def initialize code, body
    @code = code
    @body = body
  end
end
