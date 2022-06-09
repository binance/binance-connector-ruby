# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#toggle_bnb_burn' do
  let(:path) { '/sapi/v1/bnbBurn' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'without parameter' do
    let(:params) { {} }
    it 'should return oco' do
      spot_client_signed.toggle_bnb_burn
      expect(send_a_request_with_signature(:post, path)).to have_been_made
    end
  end

  context 'with symbol' do
    let(:params) { { recvWindow: 5_000 } }
    it 'should return oco' do
      spot_client_signed.toggle_bnb_burn(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
