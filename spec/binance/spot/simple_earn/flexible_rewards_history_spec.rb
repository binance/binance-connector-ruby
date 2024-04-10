# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::SimpleEarn, '#flexible_rewards_history' do
  let(:path) { '/sapi/v1/simple-earn/flexible/history/rewardsRecord' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1708632518001' }
  let(:params) { { type: 'BONUS' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation type' do
    let(:params) { { type: '' } }
    it 'should raise validation error without type' do
      expect { spot_client_signed.flexible_rewards_history(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return flexible reward history' do
    spot_client_signed.flexible_rewards_history(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        type: 'BONUS',
        recvWindow: 10_000
      }
    end

    it 'should return flexible reward history' do
      spot_client_signed.flexible_rewards_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
