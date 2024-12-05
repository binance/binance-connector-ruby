# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#adjust_flexible_loan_ltv' do
  let(:path) { '/sapi/v2/loan/flexible/adjust/ltv' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { loanCoin: '', collateralCoin: 'BNB', adjustmentAmount: 1.0, direction: 'ADDITIONAL' },
        { loanCoin: 'BUSD', collateralCoin: '', adjustmentAmount: 1.0, direction: 'ADDITIONAL' },
        { loanCoin: 'BUSD', collateralCoin: 'BNB', adjustmentAmount: '', direction: 'ADDITIONAL' },
        { loanCoin: 'BUSD', collateralCoin: 'BNB', adjustmentAmount: 1.0, direction: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.adjust_flexible_loan_ltv(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { loanCoin: 'BUSD', collateralCoin: 'BNB', adjustmentAmount: 1.0, direction: 'ADDITIONAL' } }
    it 'should return flexible Loan Adjust LTV' do
      spot_client_signed.adjust_flexible_loan_ltv(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
