# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#new_listen_key' do
  let(:path) { '/api/v3/userDataStream' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    # mocking_signature_and_ts(**params)
    stub_binance_request(:post, path, status, body)
  end

  it 'should create a new listen key' do
    spot_client_signed.new_listen_key
    expect(send_a_request(:post, path)).to have_been_made
  end
end
