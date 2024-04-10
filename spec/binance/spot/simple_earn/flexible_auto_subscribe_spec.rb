# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#flexible_auto_subscribe' do
  let(:path) { '/sapi/v1/simple-earn/flexible/setAutoSubscribe' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { productId: '1234', autoSubscribe: true } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation productId' do
    let(:params) { { productId: '', autoSubscribe: true } }
    it 'should raise validation error without productId' do
      expect { spot_client_signed.flexible_auto_subscribe(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation autoSubscribe' do
    let(:params) { { productId: '1234', autoSubscribe: '' } }
    it 'should raise validation error without autoSubscribe' do
      expect { spot_client_signed.flexible_auto_subscribe(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should set flexible auto subscribe' do
    spot_client_signed.flexible_auto_subscribe(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        productId: '1234',
        autoSubscribe: true,
        recvWindow: 10_000
      }
    end

    it 'should set flexible auto subscribe' do
      spot_client_signed.flexible_auto_subscribe(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
