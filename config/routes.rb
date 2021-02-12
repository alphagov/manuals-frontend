Rails.application.routes.draw do
  mount GovukPublishingComponents::Engine, at: "/component-guide"

  scope constraints: { prefix: /(guidance|hmrc-internal-manuals)/, format: "html" } do
    get "/:prefix/:manual_id", to: "manuals#index"
    get "/:prefix/:manual_id/updates", to: "manuals#updates"
    get "/:prefix/:manual_id/:section_id", to: "manuals#show"
  end

  root to: proc { [404, {}, ["Not found"]] }

  get "/healthcheck", to: GovukHealthcheck.rack_response
end
