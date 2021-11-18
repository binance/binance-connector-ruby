# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_flexible_products' do
  let(:path) { '/sapi/v1/lending/daily/product/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "status": 'ALL',
      "featured": 'ALL'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return account status' do
    spot_client_signed.savings_flexible_products(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
