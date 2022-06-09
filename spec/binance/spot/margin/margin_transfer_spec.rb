# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_transfer' do
  let(:path) { '/sapi/v1/margin/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation asset' do
    let(:params) { { asset: '', amount: 1, type: 1, recvWindow: 1_000 } }
    it 'should raise validation error without asset' do
      expect { spot_client_signed.margin_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation amount' do
    let(:params) { { asset: 'BNB', amount: '', type: 1, recvWindow: 1_000 } }
    it 'should raise validation error without amount' do
      expect { spot_client_signed.margin_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation type' do
    let(:params) { { asset: 'BNB', amount: '1', type: '', recvWindow: 1_000 } }
    it 'should raise validation error without type' do
      expect { spot_client_signed.margin_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        asset: 'BNB',
        amount: 1,
        type: 1,
        recvWindow: 1_000
      }
    end

    it 'should make a transfer' do
      spot_client_signed.margin_transfer(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
