class CdsServiceController < ApplicationController
  # Since this doesn't leverage any HTML, we don't need CSRF for our REST API calls
  skip_before_action :verify_authenticity_token

  def static
    card1 = Card.new(summary: 'Success Card', indicator: 'success',
                     source: Card::Link.new(label: 'Static CDS Service', url: 'http://example.com'))
    card1.tap do |c|
      c.detail = 'This is a test of a static success card.'
      c.links << Card::Link.new(label: 'Google', url: 'http://google.com')
      c.links << Card::Link.new(label: 'Yahoo!', url: 'http://yahoo.com')
    end

    source = Card::Link.new(label: 'Static CDS Service')

    card2 = Card.new(summary: 'Info card', indicator: 'info', source: source)
    card3 = Card.new(summary: 'Warning card', indicator: 'warning', source: source)
    card4 = Card.new(summary: 'Hard stop card', indicator: 'hard-stop', source: source)

    response = CdsServiceResponse.new
    response.cards = [card1, card2, card3, card4]

    render json: response
  end

  def registry
    render json: {
      services: [
        {
          hook: 'patient-view',
          name: 'Static CDS Service',
          description: 'An example static CDS service',
          url: static_service_url
        }
      ]
    }
  end
end
