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
    if document['details']['sections'].present?
      document['details']['sections'].map do | group |
        SectionGroupPresenter.new(group)
      end
    else
      []
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

end
