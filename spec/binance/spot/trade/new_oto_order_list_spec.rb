# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#new_oto_order_list' do
  let(:path) { '/api/v3/orderList/oto' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      symbol: 'BNBUSDT',
      workingType: 'LIMIT',
      workingSide: 'BUY',
      workingPrice: 1.0,
      workingQuantity: 1.0,
      pendingType: 'LIMIT',
      pendingSide: 'BUY',
      pendingQuantity: 1.0
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { symbol: '', workingType: 'LIMIT', workingSide: 'BUY', workingPrice: 1.0, workingQuantity: 1.0, pendingType: 'LIMIT', pendingSide: 'BUY', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: '', workingSide: 'BUY', workingPrice: 1.0, workingQuantity: 1.0, pendingType: 'LIMIT', pendingSide: 'BUY', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: 'LIMIT', workingSide: '', workingPrice: 1.0, workingQuantity: 1.0, pendingType: 'LIMIT', pendingSide: 'BUY', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: 'LIMIT', workingSide: 'BUY', workingPrice: '', workingQuantity: 1.0, pendingType: 'LIMIT', pendingSide: 'BUY', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: 'LIMIT', workingSide: 'BUY', workingPrice: 1.0, workingQuantity: '', pendingType: 'LIMIT', pendingSide: 'BUY', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: 'LIMIT', workingSide: 'BUY', workingPrice: 1.0, workingQuantity: 1.0, pendingType: '', pendingSide: 'BUY', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: 'LIMIT', workingSide: 'BUY', workingPrice: 1.0, workingQuantity: 1.0, pendingType: 'LIMIT', pendingSide: '', pendingQuantity: 1.0 },
        { symbol: 'BNBUSDT', workingType: 'LIMIT', workingSide: 'BUY', workingPrice: 1.0, workingQuantity: 1.0, pendingType: 'LIMIT', pendingSide: 'BUY', pendingQuantity: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.new_oto_order_list(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  it 'should create a new oto order ' do
    spot_client_signed.new_oto_order_list(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end

  context 'with parameters' do
    # it should add parameters together to place an order, but we are testing if the parameters can be add to url
    let(:params) do
      {
        symbol: 'BNBUSDT',
        workingType: 'LIMIT',
        workingSide: 'BUY',
        workingPrice: 1.0,
        workingQuantity: 1.0,
        pendingType: 'LIMIT',
        pendingSide: 'BUY',
        pendingQuantity: 1.0,
        recvWindow: 50_000
      }
    end
    it 'should create a new oto order' do
      spot_client_signed.new_oto_order_list(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
