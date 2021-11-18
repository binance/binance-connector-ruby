# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_coin_list' do
  let(:path) { '/sapi/v1/mining/pub/coinList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return coin list' do
    spot_client_signed.mining_coin_list
    expect(send_a_request(:get, path)).to have_been_made
  end
end
