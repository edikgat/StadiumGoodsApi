# frozen_string_literal: true

shared_examples 'set request maker' do
  it 'set CuncurrencyRequestMaker' do
    expect(api_check.request_maker).to be_a(CuncurrencyRequestMaker)
  end

  it 'set max_restarts' do
    expect(api_check.request_maker.max_restarts).to be(30)
  end

  it 'set concurrency_level' do
    expect(api_check.request_maker.concurrency_level).to be(10)
  end
end
