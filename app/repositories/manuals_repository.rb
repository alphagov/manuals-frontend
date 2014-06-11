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

    if File.exists?(path)
      build_ostruct(JSON.parse(File.open(path).read))
    end
  end

  def fetch_from_api(manual_id, section_id)
    path = ['guidance', manual_id, section_id].compact.join('/')

    content_api.artefact(path)
  end

  def local_manual_exists?(manual_id)
    manual_id == 'employment-income-manual'
  end

  def build_ostruct(value)
    case value
    when Hash
      OpenStruct.new(value.map.with_object({}) { |(k, v), hash|
        hash[k] = build_ostruct(v)
      })
    when Array
      value.map { |v| build_ostruct(v) }
    else
      value
    end
  end
end
