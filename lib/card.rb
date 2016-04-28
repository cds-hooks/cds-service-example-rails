class Card
  attr_accessor :detail, :links
  attr_reader :summary, :indicator, :source

  @@INDICATORS = %w(success info warning hard-stop)

  def initialize(summary:, indicator:, source:)
    @summary = summary
    @indicator = indicator
    @source = source
    @links = []
  end

  def as_json(_=nil)
    json = {
      summary: @summary,
      indicator: @indicator
    }

    if @detail
      json[:detail] = @detail
    end

    source = {name: @source.label}
    source[:url] = @source.url if @source.url
    json[:source] = source

    links = []
    @links.each do |link|
      links << {
        label: link.label,
        url: link.url
      }
    end

    unless links.empty?
      json[:links] = links
    end

    json
  end

  class Link
    attr_reader :label, :url

    def initialize(label:, url: nil)
      @label = label
      @url = url
    end
  end
end
