class ManualsRepository

  def fetch(manual_id, section_id = nil)
    section_id ||= 'index'
    fetch_json("public/#{manual_id}/#{section_id}.json")
  end

  private

  def fetch_json(path)
    file = OpenStruct.new(JSON.parse(File.open(path).read))
  end

end
