# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#deposit_address' do
  let(:path) { '/sapi/v1/capital/deposit/address' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without coin' do
      expect { spot_client_signed.deposit_address(coin: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        coin: 'BNB',
        network: 'bnb_network',
        recvWindow: 1_000
      }
    end
    it 'should return deposit address' do
      spot_client_signed.deposit_address(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
