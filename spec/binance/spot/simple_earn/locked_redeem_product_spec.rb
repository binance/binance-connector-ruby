# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#locked_redeem_product' do
  let(:path) { '/sapi/v1/simple-earn/locked/redeem' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { positionId: '1234' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation positionId' do
    let(:params) { { positionId: '' } }
    it 'should raise validation error without positionId' do
      expect { spot_client_signed.locked_redeem_product(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should redeem locked product' do
    spot_client_signed.locked_redeem_product(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        positionId: '1234',
        recvWindow: 10_000
      }
    end

    it 'should redeem locked product' do
      spot_client_signed.locked_redeem_product(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
