# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_product_list' do
  let(:path) { '/sapi/v1/lending/project/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      asset: 'BNB',
      type: 'REGULAR',
      status: 'ALL',
      isSortAsc: true,
      sortBy: 'START_TIME',
      current: 1,
      size: 10
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without type' do
      expect { spot_client_signed.savings_product_list(type: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return product list' do
    spot_client_signed.savings_product_list(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
