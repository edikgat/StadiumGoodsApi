# frozen_string_literal: true

require 'rails_helper'

describe ApiCheck::Instagram do
  subject(:api_check) do
    described_class.new(force: force)
  end

  let(:force) { false }

  describe '#request_maker' do
    it_behaves_like 'set request maker'
    it 'set url' do
      expect(api_check.request_maker.url).to eql('https://takehome.io/instagram')
    end
  end

  describe '#result' do
    context 'success' do
      before do
        success_instagram_stub
      end
      it 'responds with parsed result' do
        expect(api_check.result).to eql([{ 'picture' => 'food', 'username' => 'hipster1' },
                                         { 'picture' => 'cat', 'username' => 'hipster2' }])
      end
    end
    context 'error' do
      before do
        error_instagram_stub
      end
      it 'responds with parsed result' do
        expect(api_check.result).to be(nil)
      end
    end
    it 'uses cache' do
      Rails.cache.expects(:fetch).with(:instagram,
                                       expires_in: 1.minute,
                                       force: false,
                                       skip_nil: true)
      api_check.result
    end

    context 'force == true' do
      let(:force) { true }

      it 'reset cache' do
        Rails.cache.expects(:fetch).with(:instagram,
                                         expires_in: 1.minute,
                                         force: true,
                                         skip_nil: true)
        api_check.result
      end
    end
  end
end
