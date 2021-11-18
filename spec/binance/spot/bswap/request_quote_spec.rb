# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Bswap, '#request_quote' do
  let(:path) { '/sapi/v1/bswap/quote' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { quoteAsset: '', baseAsset: 'BUSD', quoteQty: 1 },
        { quoteAsset: 'USDT', baseAsset: '', quoteQty: 1 },
        { quoteAsset: 'USDT', baseAsset: 'BUSD', quoteQty: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.request_quote(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { quoteAsset: 'USDT', baseAsset: 'BUSD', quoteQty: 1, recvWindow: 10_000 } }
    it 'should return request quote' do
      spot_client_signed.request_quote(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
