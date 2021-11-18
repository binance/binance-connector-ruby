# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_futures_internal_transfer' do
  let(:path) { '/sapi/v1/sub-account/futures/internalTransfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { fromEmail: '', toEmail: 'bob@test.com', futuresType: 1, asset: 'USDT', amount: 0.01 },
        { fromEmail: 'alice@test.com', toEmail: '', futuresType: 1, asset: 'USDT', amount: 0.01 },
        { fromEmail: 'alice@test.com', toEmail: 'bob@test.com', futuresType: '', asset: 'USDT', amount: 0.01 },
        { fromEmail: 'alice@test.com', toEmail: 'bob@test.com', futuresType: 1, asset: '', amount: 0.01 },
        { fromEmail: 'alice@test.com', toEmail: 'bob@test.com', futuresType: 1, asset: 'USDT', amount: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_futures_internal_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { fromEmail: 'alice@test.com', toEmail: 'bob@test.com', futuresType: 1, asset: 'USDT', amount: 0.01 } }
    it 'should transfer' do
      spot_client_signed.sub_account_futures_internal_transfer(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
