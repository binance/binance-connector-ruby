# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_margin_transfer' do
  let(:path) { '/sapi/v1/sub-account/margin/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "email": 'alice@test.com',
      "asset": 'BNB',
      "amount": 1,
      "type": 1
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', asset: 'BNB', amount: 1, type: 1 },
        { email: 'alice@test.com', asset: '', amount: 1, type: 1 },
        { email: 'alice@test.com', asset: 'BNB', amount: '', type: 1 },
        { email: 'alice@test.com', asset: 'BNB', amount: 1, type: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_margin_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  it 'should transfer funds' do
    spot_client_signed.sub_account_margin_transfer(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
