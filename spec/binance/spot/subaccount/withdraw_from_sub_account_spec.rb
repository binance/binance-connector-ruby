# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#withdraw_from_sub_account' do
  let(:path) { '/sapi/v1/managed-subaccount/withdraw' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { fromEmail: '', asset: 'USDT', amount: 0.01 },
        { fromEmail: 'alice@test.com', asset: '', amount: 0.01 },
        { fromEmail: 'alice@test.com', asset: 'USDT', amount: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.withdraw_from_sub_account(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { fromEmail: 'alice@test.com', asset: 'USDT', amount: 0.01 } }
    it 'should withdraw' do
      spot_client_signed.withdraw_from_sub_account(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
