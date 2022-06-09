# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#get_isolated_margin_data' do
  let(:path) { '/sapi/v1/margin/isolatedMarginData' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'without parameter' do
    let(:params) { {} }
    it 'should return isolated magin data' do
      spot_client_signed.get_isolated_margin_data
      expect(send_a_request_with_signature(:get, path)).to have_been_made
    end
  end

  context 'with vipLevel' do
    let(:params) do
      {
        vipLevel: 1
      }
    end
    it 'should return isolated margin data' do
      spot_client_signed.get_isolated_margin_data(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
