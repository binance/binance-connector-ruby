# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#account_info' do
  let(:path) { '/sapi/v1/account/info' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return account info detail' do
    spot_client_signed.account_info
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
