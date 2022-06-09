# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#account_snapshot' do
  let(:path) { '/sapi/v1/accountSnapshot' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without type' do
      expect { spot_client_signed.account_snapshot(type: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        type: 'SPOT',
        startTime: '1591833599000',
        endTime: '1591833599000',
        limit: 30,
        recvWindow: 1_000
      }
    end
    it 'should return account snapshot' do
      spot_client_signed.account_snapshot(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
