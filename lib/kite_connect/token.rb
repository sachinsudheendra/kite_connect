class Token
  def initialize data
    @data = data
  end

  def access_token
    @data[:access_token]
  end
end
