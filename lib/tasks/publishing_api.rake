require 'logger'
require 'gds_api/publishing_api'

class RedirectPublisher
  attr_reader :logger, :publishing_app

  def initialize(logger:, publishing_app:)
    @logger = logger
    @publishing_app = publishing_app
  end

  def call(content_id, base_path, type, destination_path)
    logger.info("Registering redirect #{content_id}: '#{base_path}' -> '#{destination_path}'")

    redirect = {
      "content_id" => content_id,
      "format" => "redirect",
      "publishing_app" => publishing_app,
      "update_type" => "major",
      "redirects" => [
        {
          "path" => base_path,
          "type" => type,
          "destination" => destination_path
        }
      ]
    }

    publishing_api.put_content_item(base_path, redirect)
  end

private
  def publishing_api
    @publishing_api ||= GdsApi::PublishingApi.new(Plek.find("publishing-api"))
  end
end

namespace :publishing_api do
  desc 'Publish special routes via publishing api'
  task :publish_special_routes do
    logger = Logger.new(STDOUT)

    publishing_api ||= GdsApi::PublishingApi.new(Plek.find("publishing-api"))

    base_path = "/guidance/employment-income-manual"

    gone_content_item = {
      format: "gone",
      content_id: "8a97dc8e-d48f-48ad-804e-862d327e1fc1",
      update_type: "major",
      publishing_app: "manuals-frontend",
      routes: [
        {
          path: base_path,
          type: "prefix"
        }
      ]
    }

    publishing_api.put_content_item(base_path, gone_content_item)
    logger.info("Registered gone route #{gone_content_item[:content_id]}: '#{base_path}'")

    redirect_publisher = RedirectPublisher.new(logger: logger, publishing_app: 'manuals-frontend')
    redirect_publisher.call('09346008-7c4f-4cc4-b8d5-19d1ebf8ef5f', '/guidance', 'exact', '/government/publications')
  end
end

desc "Temporary alias of publishing_api:publish_special_routes for backward compatibility"
task "router:register" => "publishing_api:publish_special_routes"
