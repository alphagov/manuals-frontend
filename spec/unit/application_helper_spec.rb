require 'rails_helper'
require 'gds_api/content_store'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#marked_up_date' do
    it 'returns nil when the supplied date is also nil' do
      expect(helper.marked_up_date(nil)).to be_nil
    end

    it 'returns a time element when the supplied date is present' do
      expect(helper.marked_up_date(Date.today)).to match(%r{^<time.*</time>})
    end
  end
end
