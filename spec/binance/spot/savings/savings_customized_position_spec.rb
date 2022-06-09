# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_customized_position' do
  let(:path) { '/sapi/v1/lending/project/position/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      asset: 'BNB',
      projectId: '123456',
      status: 'HOLDING'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without asset' do
      expect { spot_client_signed.savings_customized_position(asset: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return project position' do
    spot_client_signed.savings_customized_position(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
