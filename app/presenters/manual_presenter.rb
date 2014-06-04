class ManualPresenter
  delegate :title, to: :manual

  def initialize(manual)
    @manual = manual
  end

  def updated_at
    Date.parse(manual.updated_at)
  end

  def organisations
    raw_organisations.map { |org| OrganisationPresenter.new(org) }
  end

  def topics
    raw_topics.map { |topic| TopicPresenter.new(topic) }
  end

  def hmrc?
    organisations.map(&:slug).include?('hm-revenue-customs')
  end

private
  attr_reader :manual

  def raw_organisations
    manual.details.published_by || []
  end

  def raw_topics
    manual.details.topics || []
  end

  class OrganisationPresenter
    delegate :title, :slug, to: :organisation

    def initialize(organisation)
      @organisation = organisation
    end

    def path
      "/government/organisations/#{slug}"
    end

  private
    attr_reader :organisation
  end

  class TopicPresenter
    delegate :title, :slug, to: :topic

    def initialize(topic)
      @topic = topic
    end

    def path
      "/government/topics/#{slug}"
    end

  private
    attr_reader :topic
  end
end
