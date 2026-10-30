# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#order_amendments' do
  let(:path) { '/api/v3/order/amendments' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { symbol: 'BNBUSDT', orderId: 28_888_888 } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { symbol: '', orderId: 28_888_888 },
        { symbol: 'BNBUSDT', orderId: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.order_amendments(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  it 'should return order amendments' do
    spot_client_signed.order_amendments(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
