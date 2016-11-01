require 'rails_helper'
require 'gds_api/content_store'

RSpec.describe ManualPresenter do
  subject { described_class.new(manual) }
  let(:content_store) { GdsApi::ContentStore.new(Plek.new.find('content-store')) }

  context 'for a normal manual' do
    let(:manual) do
      stub_fake_manual
      content_store.content_item "/guidance/my-manual-about-burritos"
    end

    it 'does not think it is an hmrc manual' do
      expect(subject.hmrc?).to eq false
    end

    it 'does not think it is a beta manual' do
      expect(subject.beta?).to eq false
    end
  end

  context 'for an HMRC manual' do
    let(:manual) do
      stub_hmrc_manual
      content_store.content_item "/hmrc-internal-manuals/inheritance-tax-manual"
    end

    it 'knows it is an hmrc manual' do
      expect(subject.hmrc?).to eq true
    end

    it 'knows it is a beta manual' do
      expect(subject.beta?).to eq true
    end
  end
end
