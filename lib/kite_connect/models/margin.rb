class Margin
  def initialize data
    @data = data
  end

  def enabled?
    @data[:enabled]
  end

  def net
    @data[:net]
  end

  def available
    @data[:available]
  end

  def utilised
    @data[:utilised]
  end
end
