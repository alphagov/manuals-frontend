require "rails_helper"

RSpec.describe ChangeNotes do
  let(:content_store) { GdsApi::ContentStore.new(Plek.new.find("content-store")) }

  context "for any manual" do
    let(:content_item_change_notes) do
      stub_fake_manual
      content_item = content_store.content_item "/guidance/my-manual-about-burritos"

      content_item["details"]["change_notes"]
    end

    it "returns change notes grouped by year and day in descending order" do
      expected_year_groupings_order = [2020, 2016, 2014]
      expected_date_order = [
        Date.parse("2020-06-20"),
        Date.parse("2020-03-01"),
        Date.parse("2016-06-10"),
        Date.parse("2014-06-25"),
      ]

      change_notes = ChangeNotes.new(content_item_change_notes)
      change_note_dates = change_notes.by_year.flat_map { |_, updates| updates.map { |date, _| date } }

      expect(change_notes.by_year.map { |year, _| year }).to eq(expected_year_groupings_order)
      expect(change_note_dates).to eq(expected_date_order)
    end
  end
end
