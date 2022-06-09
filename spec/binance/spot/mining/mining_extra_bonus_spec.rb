# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_extra_bonus' do
  let(:path) { '/sapi/v1/mining/payment/other' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:algo) { 'sha256' }
  let(:userName) { 'mining_acct' }
  let(:coin) { 'BNB' }
  let(:params) do
    {
      algo: algo,
      userName: userName,
      coin: coin
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without algo' do
      expect { spot_client_signed.mining_extra_bonus(algo: '', userName: userName) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without userName' do
      expect { spot_client_signed.mining_extra_bonus(algo: algo, userName: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return bouns list' do
    spot_client_signed.mining_extra_bonus(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
