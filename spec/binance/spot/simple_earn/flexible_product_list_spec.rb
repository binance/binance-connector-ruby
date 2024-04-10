# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#flexible_product_list' do
  let(:path) { '/sapi/v1/simple-earn/flexible/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return simple earn flexible product list' do
    spot_client_signed.flexible_product_list(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        size: 10,
        recvWindow: 10_000
      }
    end

    it 'should return simple earn flexible product list' do
      spot_client_signed.flexible_product_list(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
