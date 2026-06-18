# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#new_oco_order_list' do
  let(:path) { '/api/v3/order/oco' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1589425967140' }

  before do
    mocking_signature_and_ts
    stub_binance_sign_request(:post, path, status, body)
  end

  it 'should create a new OCO order list' do
    spot_client_signed.new_oco_order_list(
      symbol: 'BNBUSDT',
      side: 'SELL',
      quantity: 10,
      aboveType: 'STOP_LOSS_LIMIT',
      belowType: 'STOP_LOSS'
    )
    expect(send_a_request_with_signature(:post, path)).to have_been_made
  end
end
