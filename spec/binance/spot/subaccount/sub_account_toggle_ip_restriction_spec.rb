# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_toggle_ip_restriction' do
  let(:path) { '/sapi/v1/sub-account/subAccountApi/ipRestriction' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:sub_acct_api_key) { 'the_api_key' }
  let(:email) { 'alice@test.com' }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', subAccountApiKey: sub_acct_api_key, ipRestrict: true },
        { email: email, subAccountApiKey: '', ipRestrict: true },
        { email: email, subAccountApiKey: sub_acct_api_key, ipRestrict: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_toggle_ip_restriction(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { email: email, subAccountApiKey: sub_acct_api_key, ipRestrict: true } }
    it 'should toggle the ip ipRestriction on sub account' do
      spot_client_signed.sub_account_toggle_ip_restriction(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
