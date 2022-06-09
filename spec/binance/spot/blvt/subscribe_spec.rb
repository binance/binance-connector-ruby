# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Blvt, '#subscribe' do
  let(:tokenName) { 'BTCDOWN' }
  let(:cost) { 100.11 }
  let(:path) { '/sapi/v1/blvt/subscribe' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      tokenName: tokenName,
      cost: cost
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation tokenName' do
    let(:params) { { tokenName: '', cost: cost } }
    it 'should raise validation error without tokenName' do
      expect { spot_client_signed.subscribe(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation cost' do
    let(:params) { { tokenName: tokenName, cost: '' } }
    it 'should raise validation error without cost' do
      expect { spot_client_signed.subscribe(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    it 'should subscribe to blvt' do
      spot_client_signed.subscribe(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
