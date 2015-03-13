require 'rails_helper'

describe DocumentRepository do
  subject(:document_repository) {
    DocumentRepository.new
  }

  let(:document) {
    document_repository.fetch(document_base_path)
  }

  let(:document_base_path) {
    "/guidance/a-manual/a-section"
  }

  let(:document_content_item_json) {
    {
      base_path: document_base_path,
      details: {
        breadcrumbs: [
          {
            section_id: "EIM00500",
            base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00500"
          }
        ],
        section_id: "EIM00520",
      }
    }
  }

  describe "#fetch" do
    before do
      content_store_has_item(
        document_base_path,
        document_content_item_json,
      )
    end

    it "should return a document content item" do
      expect(document.base_path).to eq(document_base_path)
    end

    context "a section that is an only-child" do
      it "#previous_sibling should be nil" do
        expect(document.previous_sibling).to be_nil
      end
    end
  end
end
