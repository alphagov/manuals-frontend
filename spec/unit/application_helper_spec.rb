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

  describe '#current_path_without_query_string' do
    it "returns the path of the current request" do
      allow(helper).to receive(:request).and_return(ActionDispatch::TestRequest.new("PATH_INFO" => '/foo/bar'))
      expect(helper.current_path_without_query_string).to eq('/foo/bar')
    end

    it "returns the path of the current request stripping off any query string parameters" do
      allow(helper).to receive(:request).and_return(ActionDispatch::TestRequest.new("PATH_INFO" => '/foo/bar', "QUERY_STRING" => 'ham=jam&spam=gram'))
      expect(helper.current_path_without_query_string).to eq('/foo/bar')
    end
  end
end
