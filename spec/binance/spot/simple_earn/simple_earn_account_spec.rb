# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#simple_earn_account' do
  let(:path) { '/sapi/v1/simple-earn/account' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return simple earn account information' do
    spot_client_signed.simple_earn_account(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        recvWindow: 10_000
      }
    end

    it 'should return simple earn account information' do
      spot_client_signed.simple_earn_account(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
