# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#ping' do
  let(:path) { '/api/v3/ping' }
  let(:body) { {}.to_json }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return empty body' do
    spot_client.ping
    expect(send_a_request(:get, path)).to have_been_made
  end
end
