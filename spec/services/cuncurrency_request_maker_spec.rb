# frozen_string_literal: true

require 'rails_helper'

describe CuncurrencyRequestMaker do
  subject(:request_maker) do
    described_class.new('https://takehome.io/instagram',
                        max_restarts: max_restarts,
                        concurrency_level: concurrency_level)
  end

  let(:url) { 'https://takehome.io/instagram' }
  let(:max_restarts) { 25 }
  let(:concurrency_level) { 5 }

  describe '#process' do
    context 'success' do
      before do
        success_instagram_stub
      end
      it 'responds with parsed result' do
        expect(request_maker.process).to eql([{ 'picture' => 'food', 'username' => 'hipster1' },
                                              { 'picture' => 'cat', 'username' => 'hipster2' }])
      end

      it 'stores result' do
        request_maker.process
        expect(request_maker.result).to eql([{ 'picture' => 'food', 'username' => 'hipster1' },
                                             { 'picture' => 'cat', 'username' => 'hipster2' }])
      end

      it 'not restart requests' do
        request_maker.process
        expect(request_maker.restarts).to be(0)
      end
    end
    context 'error' do
      before do
        error_instagram_stub
      end
      it 'responds with parsed result' do
        expect(request_maker.process).to be(nil)
      end

      it 'stores result' do
        request_maker.process
        expect(request_maker.result).to be(nil)
      end

      it 'restart requests' do
        request_maker.process
        expect(request_maker.restarts).to be(25)
      end

      context 'other max restarts' do
        let(:max_restarts) { 45 }

        it 'restart requests' do
          request_maker.process
          expect(request_maker.restarts).to be(45)
        end
      end
    end
    context 'invalid json at response' do
      before do
        response_stub(url, 'invalid json', 200)
      end
      it 'responds with parsed result' do
        expect(request_maker.process).to be(nil)
      end

      it 'stores result' do
        request_maker.process
        expect(request_maker.result).to be(nil)
      end

      it 'restart requests' do
        request_maker.process
        expect(request_maker.restarts).to be(25)
      end
    end
  end
end
