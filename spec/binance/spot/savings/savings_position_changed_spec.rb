# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_position_changed' do
  let(:path) { '/sapi/v1/lending/positionChanged' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:lot) { 1 }
  let(:positionId) { 2 }
  let(:projectId) { 'BUSD001' }
  let(:params) do
    {
      "projectId": projectId,
      "lot": lot,
      "positionId": positionId
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without projectId' do
      expect { spot_client_signed.savings_position_changed(projectId: '', lot: lot) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without lot' do
      expect { spot_client_signed.savings_position_changed(projectId: projectId, lot: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return purchase record' do
    spot_client_signed.savings_position_changed(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
