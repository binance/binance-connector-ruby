# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#flexible_personal_left_quota' do
  let(:path) { '/sapi/v1/simple-earn/flexible/personalLeftQuota' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { productId: 'BTC001' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation productId' do
    let(:params) { { productId: '' } }
    it 'should raise validation error without productId' do
      expect { spot_client_signed.flexible_personal_left_quota(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return flexible personal left quota' do
    spot_client_signed.flexible_personal_left_quota(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        productId: 'BTC001',
        recvWindow: 10_000
      }
    end

    it 'should return flexible personal left quota' do
      spot_client_signed.flexible_personal_left_quota(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
