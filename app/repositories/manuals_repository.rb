require 'gds_api/helpers'

class ManualsRepository
  include GdsApi::Helpers

  def fetch(manual_id, section_id = nil)
    if local_manual_exists?(manual_id)
      fetch_from_file(manual_id, section_id)
    else
      fetch_from_api(manual_id, section_id)
    end
  end

private
  def fetch_from_file(manual_id, section_id)
    section_id ||= 'index'
    path = "public/#{manual_id}/#{section_id}.json"

    OpenStruct.new(JSON.parse(File.open(path).read))
  end

  def fetch_from_api(manual_id, section_id)
    path = ['guidance', manual_id, section_id].compact.join('/')

    content_api.artefact(path)
  end

  def local_manual_exists?(manual_id)
    %w(immigration employment-income-manual).include?(manual_id)
  end
end
