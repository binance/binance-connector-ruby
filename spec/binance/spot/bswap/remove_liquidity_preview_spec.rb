# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Bswap, '#remove_liquidity_preview' do
  let(:path) { '/sapi/v1/bswap/removeLiquidityPreview' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { poolId: '', type: 'SINGLE', quoteAsset: 'USDT', shareAmount: 1 },
        { poolId: 2, type: '', quoteAsset: 'USDT', shareAmount: 1 },
        { poolId: 2, type: 'SINGLE', quoteAsset: '', shareAmount: 1 },
        { poolId: 2, type: 'SINGLE', quoteAsset: 'USDT', shareAmount: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.remove_liquidity_preview(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { poolId: 2, type: 'SINGLE', quoteAsset: 'USDT', shareAmount: 1 } }
    it 'should remove liquidity preview' do
      spot_client_signed.remove_liquidity_preview(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
