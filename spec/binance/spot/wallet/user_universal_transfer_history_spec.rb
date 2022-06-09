# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#user_universal_transfer_history' do
  let(:path) { '/sapi/v1/asset/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without type' do
      expect { spot_client_signed.user_universal_transfer_history(type: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        type: 1,
        recvWindow: 1_000
      }
    end
    it 'should return universal transfer history' do
      spot_client_signed.user_universal_transfer_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
