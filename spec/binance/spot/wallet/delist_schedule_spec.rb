# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#delist_schedule' do
  let(:path) { '/sapi/v1/spot/delist-schedule' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return symbols delist schedule for spot' do
    spot_client_signed.delist_schedule
    expect(send_a_request(:get, path).with(headers: { 'X-MBX-APIKEY' => '' })).to have_been_made
  end
end
