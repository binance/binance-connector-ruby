# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#locked_subscription_preview' do
  let(:path) { '/sapi/v1/simple-earn/locked/subscriptionPreview' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { projectId: 'Bnb*120', amount: 1.0 } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation projectId' do
    let(:params) { { projectId: '', amount: 1.0 } }
    it 'should raise validation error without projectId' do
      expect { spot_client_signed.locked_subscription_preview(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation amount' do
    let(:params) { { projectId: 'Bnb*120', amount: '' } }
    it 'should raise validation error without amount' do
      expect { spot_client_signed.locked_subscription_preview(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return locked subscription preview' do
    spot_client_signed.locked_subscription_preview(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        projectId: '1234',
        amount: 1.0,
        recvWindow: 10_000
      }
    end

    it 'should return locked subscription preview' do
      spot_client_signed.locked_subscription_preview(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
