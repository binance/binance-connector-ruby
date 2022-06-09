# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_asset' do
  let(:path) { '/sapi/v1/margin/asset' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:asset) { 'BNB' }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation asset' do
    let(:params) { { asset: '' } }
    it 'should raise validation error without asset' do
      expect { spot_client_signed.margin_asset(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:path) { "/sapi/v1/margin/asset?asset=#{asset}" }
    it 'should query margin asset' do
      spot_client_signed.margin_asset(asset: asset)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
