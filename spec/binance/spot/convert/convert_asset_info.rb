# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_asset_info' do
  let(:path) { '/sapi/v1/convert/assetInfo' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return supported assets precision information' do
    spot_client_signed.convert_asset_info
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
