# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_all_pairs' do
  let(:path) { '/sapi/v1/margin/allPairs ' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_request(:get, path, status, body)
  end

  it 'should return margin all pairs' do
    spot_client_signed.margin_all_pairs
    expect(send_a_request(:get, path)).to have_been_made
  end
end
