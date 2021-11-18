# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Bswap, '#add_liquidity' do
  let(:path) { '/sapi/v1/bswap/liquidityAdd' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { poolId: '', asset: 'USDT', quantity: 1 },
        { poolId: 2, asset: '', quantity: 1 },
        { poolId: 2, asset: 'USDT', quantity: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.add_liquidity(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { poolId: 2, asset: 'USDT', quantity: 1 } }
    it 'should add liquidity' do
      spot_client_signed.add_liquidity(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
