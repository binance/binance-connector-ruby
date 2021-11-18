# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_account' do
  let(:path) { '/sapi/v1/lending/union/account' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return user account' do
    spot_client_signed.savings_account(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
