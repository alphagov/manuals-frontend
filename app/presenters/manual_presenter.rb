class ManualPresenter
  delegate :title, to: :manual

  def initialize(manual)
    @manual = manual
  end

  def updated_at
    Date.parse(manual.updated_at)
  end

  def organisations
    organisation_tags.map { |org| OrganisationPresenter.new(org) }
  end

  def topics
    raw_topics.map { |topic| TopicPresenter.new(topic) }
  end

  def hmrc?
    organisations.map(&:slug).include?('hm-revenue-customs')
  end

  def url
    manual.web_url
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroupPresenter.new(group) }
  end

  def body
    manual.details.summary
  end

private
  attr_reader :manual

  def raw_section_groups
    manual.details.section_groups || []
  end

  def raw_topics
    manual.details.topics || []
  end

  def tags
    manual.tags || []
  end

  def organisation_tags
    tags.select { |t| t.details.type == 'organisation' }
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
