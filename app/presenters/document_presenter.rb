class DocumentPresenter < SimpleDelegator
  delegate :manual, to: :document
  attr_reader :document

  def initialize(document:)
    @document = document
    super(document)
  end
end
