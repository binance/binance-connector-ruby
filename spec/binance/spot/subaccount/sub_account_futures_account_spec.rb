# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_futures_account' do
  let(:path) { '/sapi/v2/sub-account/futures/account' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', futuresType: 1 },
        { email: 'alice@test.com', futuresType: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_futures_account(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { email: 'alice@test.com', futuresType: 1 } }
    it 'should return sub account futures account' do
      spot_client_signed.sub_account_futures_account(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
