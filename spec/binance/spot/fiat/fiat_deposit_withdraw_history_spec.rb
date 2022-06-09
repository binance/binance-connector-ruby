# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Fiat, '#fiat_deposit_withdraw_history' do
  let(:path) { '/sapi/v1/fiat/orders' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    let(:params) { { transactionType: '' } }
    it 'should raise validation error without mandatory params' do
      expect { spot_client_signed.fiat_deposit_withdraw_history(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with params' do
    let(:params) { { transactionType: 0 } }
    it 'should return deposit withdrawal history' do
      spot_client_signed.fiat_deposit_withdraw_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
