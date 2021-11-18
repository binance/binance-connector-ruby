# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_algo_list' do
  let(:path) { '/sapi/v1/mining/pub/algoList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return algo list' do
    spot_client_signed.mining_algo_list
    expect(send_a_request(:get, path)).to have_been_made
  end
end
