# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_all_assets' do
  let(:path) { '/sapi/v1/margin/allAssets ' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_request(:get, path, status, body)
  end

  it 'should return margin all assets' do
    spot_client_signed.margin_all_assets
    expect(send_a_request(:get, path)).to have_been_made
  end
end
