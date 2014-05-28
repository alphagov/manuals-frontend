class DocumentPresenter

  def initialize(document)
    @document = document
  end

  def section_id
    document['details']['manual-section-id']
  end

  def title
    document['title']
  end

  def body
    document['details']['body']
  end

  def section_groups
    document['details']['sections'].map do | group |
      SectionGroupPresenter.new(group)
    end
  end

  def breadcrumbs
    root = OpenStruct.new(link: '/guidance/employment-income-manual', label: 'Contents')
    crumbs = []
    if document['details']['breadcrumbs'].present?
      crumbs = document['details']['breadcrumbs'][1..-2].map do | section_id |
        OpenStruct.new(link: "/guidance/employment-income-manual/#{section_id}", label: section_id)
      end
    end
    [root] + crumbs
  end

  def organisations
    organisations = document['details']['published_by']
    if organisations
      document['details']['published_by'].map do | organisation|
        OrganisationPresenter.new(organisation)
      end
    else # This is temporary as a way to get around the HMRC placeholder manual not having any organisation data
      organisation = { 'title' => 'HM Revenue & Customs', 'slug' => 'hm-revenue-customs', 'abbreviation' => 'HMRC' }
      [OrganisationPresenter.new(organisation)]
    end
  end

  def topics
    topics = document['details']['topics']
    if topics
      topics.map do | topic|
        TopicPresenter.new(topic)
      end
    end
  end

  def hmrc?
    organisations.map(&:slug).include?('hm-revenue-customs')
  end

private
  attr_reader :document


  class SectionGroupPresenter

    def initialize(section_group)
      @group = section_group
    end

    def title
      group['title']
    end

    def sections
      group['sections'].map do | section |
        SectionPresenter.new(section)
      end
    end

  private
    attr_reader :group

  end

  class SectionPresenter

    def initialize(section)
      @section = section
    end

    def title
      section['title']
    end

    def section_id
      section['manual-section-id']
    end

    def summary
      section['summary']
    end

    def body
      section['body']
    end

  private
    attr_reader :section

  end

  class OrganisationPresenter

    def initialize(organisation)
      @organisation = organisation
    end

    def title
      organisation['title']
    end

    def slug
      organisation['slug']
    end

    def path
      '/government/organisations/' + slug
    end

    private
      attr_reader :organisation
  end

  class TopicPresenter

    def initialize(topic)
      @topic = topic
    end

    def title
      topic['title']
    end

    def path
      '/government/topics/' + slug
    end

    def slug
      topic['slug']
    end

    private
      attr_reader :topic
  end

end
