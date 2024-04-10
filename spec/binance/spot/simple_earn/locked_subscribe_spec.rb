# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#locked_subscribe' do
  let(:path) { '/sapi/v1/simple-earn/locked/subscribe' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { projectId: 'Bnb*120', amount: 1.0 } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation projectId' do
    let(:params) { { projectId: '', amount: 1.0 } }
    it 'should raise validation error without projectId' do
      expect { spot_client_signed.locked_subscribe(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation amount' do
    let(:params) { { projectId: 'Bnb*120', amount: '' } }
    it 'should raise validation error without amount' do
      expect { spot_client_signed.locked_subscribe(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should subscribe to locked product' do
    spot_client_signed.locked_subscribe(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        projectId: 'Bnb*120',
        amount: 1.0,
        recvWindow: 10_000
      }
    end

    it 'should subscribe to locked product' do
      spot_client_signed.locked_subscribe(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
