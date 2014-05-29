class ManualPresenter

  def initialize(manual_id, document)
    @manual_id = manual_id
    @document = document
  end

  def title
    @manual_id.titlecase
  end

  def organisations
    organisations = @document['details']['published_by']
    if organisations
      @document['details']['published_by'].map do | organisation|
        OrganisationPresenter.new(organisation)
      end
    else # This is temporary as a way to get around the HMRC placeholder manual not having any organisation data
      organisation = { 'title' => 'HM Revenue & Customs', 'slug' => 'hm-revenue-customs', 'abbreviation' => 'HMRC' }
      [OrganisationPresenter.new(organisation)]
    end
  end

  def topics
    topics = @document['details']['topics']
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
