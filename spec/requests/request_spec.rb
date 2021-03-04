require "rails_helper"

RSpec.describe "Manuals" do
  describe "GET ManualsController#index" do
    it "returns successfully" do
      slug = "/guidance/my-manual-about-burritos"
      stub_fake_manual(base_path: slug)
      get slug

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET ManualsController#index with unacceptable 'Accept' header" do
    it "returns 406 Not Acceptable" do
      slug = "/guidance/my-manual-about-burritos"
      stub_fake_manual(base_path: slug)
      get slug, params: {}, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:not_acceptable)
    end
  end

  describe "GET ManualsController#show" do
    it "returns successfully" do
      slug = "/guidance/my-manual-about-burritos"
      stub_fake_manual(base_path: slug)
      section = "/guidance/my-manual-about-burritos/section"
      stub_fake_manual(base_path: section)
      get section

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET ManualsController#show with unacceptable 'Accept' header" do
    it "returns 406 Not Acceptable" do
      slug = "/guidance/my-manual-about-burritos"
      stub_fake_manual(base_path: slug)
      section = "/guidance/my-manual-about-burritos/section"
      stub_fake_manual(base_path: section)
      get section, params: {}, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:not_acceptable)
    end
  end
end
