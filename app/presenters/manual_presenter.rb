class ManualPresenter

  def initialize(manual)
    @manual = manual
  end

  def title
    manual['title']
  end

  def organisations
    organisations = manual['details']['published_by']
    if organisations
      manual['details']['published_by'].map do | organisation|
        OrganisationPresenter.new(organisation)
      end
    else
      []
    end
  end

  def topics
    topics = manual['details']['topics']
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
    attr_reader :manual

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
