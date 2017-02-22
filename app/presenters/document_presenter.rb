class DocumentPresenter < SimpleDelegator
  delegate :manual, to: :document
  attr_reader :document

  def initialize(document:)
    @document = document
    super(document)
  end

  # TODO: Manual sections should be tagged to taxons like manuals are.
  # Unfortunately, that workflow doesn't yet exist, which means we need to
  # manually generate taxonomy breadcrumbs for manual sections by using the
  # manual's' taxonomy breadcrumbs and appending the manual section metadata to
  # the end.
  # This code should be deleted once manual sections are tagged to the same
  # taxons as the parent manual.
  def taxonomy_breadcrumbs
    @taxonomy_breadcrumbs ||= begin
      document_breadcrumbs = nav_helper.taxon_breadcrumbs[:breadcrumbs]

      # Remove the last element, which is the manual as `current`.
      document_breadcrumbs.pop

      # Re-add the manual entry, now as a regular breadcrumb
      document_breadcrumbs << {
        title: manual.title,
        url: manual.url
      }

      # Add the section breadcrumb a `current`
      document_breadcrumbs << {
        title: document.title,
        is_current_page: true
      }

      document_breadcrumbs
    end
  end

  def nav_helper
    @nav_helper ||= GovukNavigationHelpers::NavigationHelper.new(
      manual.content_store_manual
    )
  end
end
