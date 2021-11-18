# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Bswap, '#get_swap_pools' do
  let(:path) { '/sapi/v1/bswap/pools' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return pools' do
    spot_client.swap_pools
    expect(send_a_request(:get, path)).to have_been_made
  end
end
