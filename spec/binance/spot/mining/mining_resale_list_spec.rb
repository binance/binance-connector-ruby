# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_resale_list' do
  let(:path) { '/sapi/v1/mining/hash-transfer/config/details/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:pageIndex) { 1 }
  let(:pageSize) { 100 }
  let(:params) do
    {
      pageIndex: pageIndex,
      pageSize: pageSize
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return hashrate resale list' do
    spot_client_signed.mining_resale_list(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
