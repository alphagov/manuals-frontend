class DocumentPresenter < SimpleDelegator
  delegate :manual, to: :document
  attr_reader :document

  def initialize(document:)
    @document = document
    super(document)
  end

  def nav_helper
    @nav_helper ||= GovukNavigationHelpers::NavigationHelper.new(
      manual.content_store_manual
    )
  end
end
