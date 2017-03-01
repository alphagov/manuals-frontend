class ManualPresenter < SimpleDelegator
  def initialize(manual:, view_context:)
    @view_context = view_context
    @manual = manual
    super(manual)
  end

  def updated_at
    @view_context.marked_up_date(super)
  end

  def organisations
    super.map do |organisation|
      @view_context.link_to(organisation['title'], organisation['web_url'])
    end
  end

  def updates_url
    "#{url}/updates"
  end

  def metadata
    {
      from: organisations,
      first_published: @view_context.marked_up_date(first_published_at),
      other: {
        "Updated" => "#{updated_at}, #{@view_context.link_to 'see all updates', updates_url}",
      }
    }
  end

  def taxonomy_breadcrumbs
    @taxonomy_breadcrumbs ||= nav_helper.taxon_breadcrumbs[:breadcrumbs]
  end

  def nav_helper
    @nav_helper ||=
      GovukNavigationHelpers::NavigationHelper.new(@manual.content_store_manual.to_h)
  end
end
