# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#get_flexible_loan_ltv_adjustment_history' do
  let(:path) { '/sapi/v2/loan/flexible/ltv/adjustment/history' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return flexible Loan LTV Adjustment History' do
    spot_client_signed.get_flexible_loan_ltv_adjustment_history
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
