# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_add_ip_list' do
  let(:path) { '/sapi/v1/sub-account/subAccountApi/ipRestriction/ipList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:sub_acct_api_key) { 'the_api_key' }
  let(:email) { 'alice@test.com' }
  let(:ip) { '1.2.3.4' }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', subAccountApiKey: sub_acct_api_key, ipAddress: ip },
        { email: email, subAccountApiKey: '', ipAddress: ip },
        { email: email, subAccountApiKey: sub_acct_api_key, ipAddress: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_add_ip_list(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { email: email, subAccountApiKey: sub_acct_api_key, ipAddress: ip } }
    it 'should add ip list' do
      spot_client_signed.sub_account_add_ip_list(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
