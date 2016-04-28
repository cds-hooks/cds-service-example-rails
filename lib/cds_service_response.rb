class CdsServiceResponse
  attr_accessor :cards

  def initialize(service_response=nil)
    @cards = []
  end

  def as_json(_=nil)
    { cards: @cards }
  end
end
