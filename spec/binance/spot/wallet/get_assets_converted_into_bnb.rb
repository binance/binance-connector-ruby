# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#get_assets_converted_into_bnb' do
  let(:path) { '/sapi/v1/asset/dust-btc' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:post, path, status, body)
  end

  it 'should return assets that can be converted into BNB' do
    spot_client_signed.get_assets_converted_into_bnb
    expect(send_a_request_with_signature(:post, path)).to have_been_made
  end
end
