# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#system_status' do
  let(:path) { '/sapi/v1/system/status' }
  let(:body) { {}.to_json }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return empty body' do
    spot_client.system_status
    expect(send_a_request(:get, path)).to have_been_made
  end
end
