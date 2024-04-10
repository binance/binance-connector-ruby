# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#flexible_subscription_preview' do
  let(:path) { '/sapi/v1/simple-earn/flexible/subscriptionPreview' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { productId: 'BTC001', amount: 0.01 } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation productId' do
    let(:params) { { productId: '', amount: 0.01 } }
    it 'should raise validation error without productId' do
      expect { spot_client_signed.flexible_subscription_preview(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation amount' do
    let(:params) { { productId: 'BTC001', amount: '' } }
    it 'should raise validation error without amount' do
      expect { spot_client_signed.flexible_subscription_preview(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return locked subscription preview' do
    spot_client_signed.flexible_subscription_preview(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        productId: 'BTC001',
        amount: 0.01,
        recvWindow: 10_000
      }
    end

    it 'should return locked subscription preview' do
      spot_client_signed.flexible_subscription_preview(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
