# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#cloud_mining_payment_and_refund_history' do
  let(:path) { '/sapi/v1/asset/ledger-transfer/cloud-mining/queryByPage' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return Cloud-Mining payment and refund history' do
    spot_client_signed.cloud_mining_payment_and_refund_history
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
