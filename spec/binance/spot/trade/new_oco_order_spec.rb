# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#new_oco_order' do
  let(:path) { '/api/v3/order/oco' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      symbol: 'BNBUSDT',
      side: 'BUY',
      quantity: 10,
      aboveType: 'LIMIT_MAKER',
      belowType: 'LIMIT_MAKER'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { symbol: '', side: 'BUY', quantity: 10, aboveType: 'LIMIT_MAKER', belowType: 'LIMIT_MAKER' },
        { symbol: 'BNBUSDT', side: '', quantity: 10, aboveType: 'LIMIT_MAKER', belowType: 'LIMIT_MAKER' },
        { symbol: 'BNBUSDT', side: 'BUY', quantity: '', aboveType: 'LIMIT_MAKER', belowType: 'LIMIT_MAKER' },
        { symbol: 'BNBUSDT', side: 'BUY', quantity: 10, aboveType: '', belowType: 'LIMIT_MAKER' },
        { symbol: 'BNBUSDT', side: 'BUY', quantity: 10, aboveType: 'LIMIT_MAKER', belowType: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.new_oco_order(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  it 'should create a new oco order ' do
    spot_client_signed.new_oco_order(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end

  context 'with parameters' do
    # it should add parameters together to place an order, but we are testing if the parameters can be add to url
    let(:params) do
      {
        symbol: 'BNBUSDT',
        price: '1000',
        side: 'BUY',
        quantity: 1,
        aboveType: 'LIMIT_MAKER',
        belowType: 'LIMIT_MAKER',
        abovePrice: 600,
        belowPrice: 590,
        recvWindow: 50_000
      }
    end
    it 'should create a new oco order' do
      spot_client_signed.new_oco_order(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
