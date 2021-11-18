# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#get_sub_account_list' do
  let(:path) { '/sapi/v1/sub-account/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return sub account list' do
    spot_client_signed.get_sub_account_list
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end

  context 'with params' do
    let(:params) { { recvWindow: 10_000 } }

    it 'should return sub account list' do
      spot_client_signed.get_sub_account_list(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
