# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_resale_request' do
  let(:path) { '/sapi/v1/mining/hash-transfer/config' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:userName) { 'mining_acct' }
  let(:algo) { 'sha256' }
  let(:startDate) { 1_607_659_086_000 }
  let(:endDate) { 1_607_659_086_001 }
  let(:toPoolUser) { 'S19pro' }
  let(:hashRate) { 100_000_000 }
  let(:params) do
    {
      userName: userName,
      algo: algo,
      startDate: startDate,
      endDate: endDate,
      toPoolUser: toPoolUser,
      hashRate: hashRate
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { userName: '', algo: algo, startDate: startDate, endDate: endDate, toPoolUser: toPoolUser, hashRate: hashRate },
        { userName: userName, algo: '', startDate: startDate, endDate: endDate, toPoolUser: toPoolUser, hashRate: hashRate },
        { userName: userName, algo: algo, startDate: '', endDate: endDate, toPoolUser: toPoolUser, hashRate: hashRate },
        { userName: userName, algo: algo, startDate: startDate, endDate: '', toPoolUser: toPoolUser, hashRate: hashRate },
        { userName: userName, algo: algo, startDate: startDate, endDate: endDate, toPoolUser: '', hashRate: hashRate },
        { userName: userName, algo: algo, startDate: startDate, endDate: endDate, toPoolUser: toPoolUser, hashRate: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.mining_resale_request(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  it 'should return request hashrate resale' do
    spot_client_signed.mining_resale_request(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
