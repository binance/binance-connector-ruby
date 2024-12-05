# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#get_flexible_loan_assets_data' do
  let(:path) { '/sapi/v2/loan/flexible/loanable/data' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return interest rate and borrow limit of flexible loanable assets' do
    spot_client_signed.get_flexible_loan_assets_data
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
