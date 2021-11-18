# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#calculate_adjust_rate' do
  let(:path) { '/sapi/v2/futures/loan/calcAdjustLevel' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
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
        expect { spot_client_signed.calculate_adjust_rate(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { loanCoin: 'BUSD', collateralCoin: 'BTC', amount: 1, direction: 'ADDITIONAL' } }
    it 'should calculate adjust rate' do
      spot_client_signed.calculate_adjust_rate(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
