# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#new_margin_listen_key' do
  let(:path) { '/sapi/v1/userDataStream' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    stub_binance_request(:post, path, status, body)
  end

  it 'should create a new margin listen key' do
    spot_client_signed.new_margin_listen_key
    expect(send_a_request(:post, path)).to have_been_made
  end
end
