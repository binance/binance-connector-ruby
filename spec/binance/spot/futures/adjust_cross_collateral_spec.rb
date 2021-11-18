# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#adjust_cross_collateral' do
  let(:path) { '/sapi/v2/futures/loan/adjustCollateral' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { loanCoin: '', collateralCoin: 'BTC', amount: 1, direction: 'ADDITIONAL' },
        { loanCoin: 'BUSD', collateralCoin: '', amount: 1, direction: 'ADDITIONAL' },
        { loanCoin: 'BUSD', collateralCoin: 'BTC', amount: '', direction: 'ADDITIONAL' },
        { loanCoin: 'BUSD', collateralCoin: 'BTC', amount: 1, direction: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.adjust_cross_collateral(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { loanCoin: 'BUSD', collateralCoin: 'BTC', amount: 1, direction: 'ADDITIONAL' } }
    it 'should adjust cross collateral' do
      spot_client_signed.adjust_cross_collateral(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
