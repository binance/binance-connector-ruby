# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#enable_fast_withdraw' do
  let(:path) { '/sapi/v1/account/enableFastWithdrawSwitch' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  it 'should enable fast withdraw' do
    spot_client_signed.enable_fast_withdraw
    expect(send_a_request_with_signature(:post, path)).to have_been_made
  end
end
