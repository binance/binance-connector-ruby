# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#user_delegation_history' do
  let(:path) { '/sapi/v1/asset/custody/transfer-history' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { email: 'alice@test.com', startTime: 1_695_205_406_000, endTime: 1_695_291_806_000 } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { email: '', startTime: 1_695_205_406_000, endTime: 1_695_291_806_000 },
        { email: 'alice@test.com', startTime: '', endTime: 1_695_291_806_000 },
        { email: 'alice@test.com', startTime: 1_695_205_406_000, endTime: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.user_delegation_history(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  it 'should return user delegation history' do
    spot_client_signed.user_delegation_history(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
