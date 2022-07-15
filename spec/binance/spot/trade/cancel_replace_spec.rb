# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#cancel_replace' do
  let(:path) { '/api/v3/order/cancelReplace' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      symbol: 'BNBBUSD',
      side: 'BUY',
      type: 'LIMIT',
      cancelReplaceMode: 'STOP_ON_FAILURE'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { symbol: '', side: 'BUY', type: 'LIMIT', cancelReplaceMode: 'STOP_ON_FAILURE' } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.cancel_replace(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation side' do
    let(:params) { { symbol: 'BNBBUSD', side: '', type: 'LIMIT', cancelReplaceMode: 'STOP_ON_FAILURE' } }
    it 'should raise validation error without side' do
      expect { spot_client_signed.cancel_replace(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation type' do
    let(:params) { { symbol: 'BNBBUSD', side: 'BUY', type: '', cancelReplaceMode: 'STOP_ON_FAILURE' } }
    it 'should raise validation error without type' do
      expect { spot_client_signed.cancel_replace(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation cancelReplaceMode' do
    let(:params) { { symbol: 'BNBBUSD', side: 'BUY', type: '', cancelReplaceMode: 'STOP_ON_FAILURE' } }
    it 'should raise validation error without cancelReplaceMode' do
      expect { spot_client_signed.cancel_replace(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        symbol: 'BNBBUSD',
        side: 'BUY',
        type: 'LIMIT',
        cancelReplaceMode: 'STOP_ON_FAILURE',
        quantity: 1,
        timeInForce: 'GTC',
        cancelOrderId: 'my_order_1',
        recvWindow: 2_000
      }
    end
    it 'should create a new order' do
      spot_client_signed.cancel_replace(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
