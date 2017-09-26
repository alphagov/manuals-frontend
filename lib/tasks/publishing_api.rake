require 'logger'
require 'gds_api/publishing_api_v2'

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
      "base_path" => base_path,
      "schema_name" => "redirect",
      "document_type" => "redirect",
      "publishing_app" => publishing_app,
      "redirects" => [
        {
          "path" => base_path,
          "type" => type,
          "destination" => destination_path
        }
      ],
      "update_type" => "major",
    }

    publishing_api.put_content(content_id, redirect)
    publishing_api.publish(content_id)
  end

private

  def publishing_api
    @publishing_api ||= GdsApi::PublishingApiV2.new(
      Plek.new.find('publishing-api'),
      bearer_token: ENV['PUBLISHING_API_BEARER_TOKEN'] || 'example'
    )
  end
end

namespace :publishing_api do
  desc 'Publish special routes via publishing api'
  task :publish_special_routes do
    logger = Logger.new(STDOUT)

    redirect_publisher = RedirectPublisher.new(logger: logger, publishing_app: 'manuals-frontend')
    redirect_publisher.call('09346008-7c4f-4cc4-b8d5-19d1ebf8ef5f', '/guidance', 'exact', '/government/publications')
  end
end
