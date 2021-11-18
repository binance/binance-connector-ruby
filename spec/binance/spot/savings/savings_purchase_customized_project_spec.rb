# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_purchase_customized_project' do
  let(:path) { '/sapi/v1/lending/customizedFixed/purchase' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "projectId": 'project_id',
      "lot": 10
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without projectId' do
      expect { spot_client_signed.savings_purchase_customized_project(projectId: '', lot: 1) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should purchase Customized product' do
    spot_client_signed.savings_purchase_customized_project(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
