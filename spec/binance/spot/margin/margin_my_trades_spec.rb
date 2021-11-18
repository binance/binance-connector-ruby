# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_my_trades' do
  let(:path) { '/sapi/v1/margin/myTrades' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { "symbol": '', "recvWindow": 1_000 } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.margin_my_trades(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        "symbol": 'BNBUSDT',
        "startTime": '1581783387615',
        "endTime": '1581783387616',
        "fromId": 'from_id',
        "limit": 100
      }
    end
    it 'should query my trades' do
      spot_client_signed.margin_my_trades(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
