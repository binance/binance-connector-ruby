# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#wallet_balance' do
  let(:path) { '/sapi/v1/asset/wallet/balance' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return user wallet balance' do
    spot_client_signed.wallet_balance
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
