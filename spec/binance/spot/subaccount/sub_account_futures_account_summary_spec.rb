# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_futures_account_summary' do
  let(:path) { '/sapi/v2/sub-account/futures/accountSummary' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { futuresType: 1 } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validate futuresType' do
    it 'should raise validation error without futuresType' do
      expect { spot_client_signed.sub_account_futures_account_summary(futuresType: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return futures account summary' do
    spot_client_signed.sub_account_futures_account_summary(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
