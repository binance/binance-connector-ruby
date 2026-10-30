# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::DCI, '#dual_investment_positions' do
  let(:path) { '/sapi/v1/dci/product/positions' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return dual investment positions' do
    spot_client_signed.dual_investment_positions(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        status: 'PURCHASE_SUCCESS',
        pageSize: 10,
        pageIndex: 1,
        recvWindow: 10_000
      }
    end

    it 'should return dual investment positions' do
      spot_client_signed.dual_investment_positions(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
