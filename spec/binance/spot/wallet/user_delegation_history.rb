# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#user_delegation_history' do
  let(:path) { '/sapi/v1/asset/custody/transfer-history' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return user delegation History' do
    spot_client_signed.user_delegation_history
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
