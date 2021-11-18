# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_get_all_isolated_margin_pairs' do
  let(:path) { '/sapi/v1/margin/isolated/allPairs' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'without parameter' do
    it 'should return isolated margin pairs' do
      spot_client_signed.get_all_isolated_margin_pairs
      expect(send_a_request_with_signature(:get, path)).to have_been_made
    end
  end

  context 'with recvWindow' do
    let(:params) do
      {
        "recvWindow": 5000
      }
    end
    it 'should return isolated margin pairs' do
      spot_client_signed.get_all_isolated_margin_pairs(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
