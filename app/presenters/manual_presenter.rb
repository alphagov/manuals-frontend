class ManualPresenter
  delegate :title, to: :manual

  def initialize(manual)
    @manual = manual
  end

  def beta?
    # At some point some of the manuals will be in beta and some won't and we'll need to
    # check that here and return true/fase accordingly. Punting that work into the future
    # for now as I don't have time to do it before the Show The Thing deadline in two day's
    # time.

    true
  end

  def beta_message
    if hmrc?
      "This part of GOV.UK is still being built – you can <a href='http://www.hmrc.gov.uk/thelibrary/manuals.htm'>access the manuals from HMRC</a> in the meantime"
    end
  end

  def full_title
    if hmrc?
      @manual.title + ' - HMRC internal manual'
    else
      @manual.title + ' - Guidance'
    end
  end

  def updated_at
    Date.parse(manual.public_updated_at)
  end

  def organisations
    @manual.details.organisations || []
  end

  def hmrc?
    organisations.map(&:title).include?('HM Revenue & Customs')
  end

  def url
    manual.base_path
  end

  def updates_url
    "#{url}/updates"
  end

  def change_notes
    ChangeNotesPresenter.new(manual.details.change_notes || [])
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroupPresenter.new(group) }
  end

  def summary
    manual.description
  end

  def body
    manual.details.body.html_safe if manual.details.body.present?
  end

private
  attr_reader :manual

  def raw_section_groups
    manual.details.child_section_groups || []
  end
end
