# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#sub_account_transfer_log_investor' do
  let(:path) { '/sapi/v1/managed-subaccount/queryTransLogForInvestor' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', startTime: 1_640_998_861_000, endTime: 1_646_096_461_000, page: 1, limit: 10 },
        { email: 'test@test.com', startTime: '', endTime: 1_646_096_461_000, page: 1, limit: 10 },
        { email: 'test@test.com', startTime: 1_640_998_861_000, endTime: '', page: 1, limit: 10 },
        { email: 'test@test.com', startTime: 1_640_998_861_000, endTime: 1_646_096_461_000, page: '', limit: 10 },
        { email: 'test@test.com', startTime: 1_640_998_861_000, endTime: 1_646_096_461_000, page: 1, limit: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.sub_account_transfer_log_investor(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { email: 'test@test.com', startTime: 1_640_998_861_000, endTime: 1_646_096_461_000, page: 1, limit: 10 } }
    it 'should return managed sub account transfer log for investor master account' do
      spot_client_signed.sub_account_transfer_log_investor(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
