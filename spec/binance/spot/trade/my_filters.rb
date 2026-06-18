# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#my_filters' do
  let(:path) { '/api/v3/myFilters' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1589425967140' }

  before do
    mocking_signature_and_ts
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return my filters' do
    spot_client_signed.my_filters
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
