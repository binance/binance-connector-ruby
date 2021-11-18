# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#renew_listen_key' do
  let(:path) { '/api/v3/userDataStream' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:listenKey) { 'listen_key' }
  let(:params) { {} }

  before do
    stub_binance_request(:put, path, status, body)
  end

  context 'with param' do
    let(:path) { "/api/v3/userDataStream?listenKey=#{listenKey}" }
    it 'should renew a listen key' do
      spot_client_signed.renew_listen_key(listenKey)
      expect(send_a_request(:put, path)).to have_been_made
    end
  end
end
