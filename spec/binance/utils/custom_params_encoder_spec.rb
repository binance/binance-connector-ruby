# frozen_string_literal: true

RSpec.describe Binance::Utils::Faraday::CustomParamsEncoder do
  context 'encode param string' do
    it 'return an encoded string given an array with a param' do
      expect(described_class.encode_array([%w[key value]])).to eq('key=value')
    end

    it 'return an encoded string given an array with a param equals empty array' do
      expect(described_class.encode_array([['key', []]])).to eq('key')
    end

    it 'return an encoded string given an array with a param equals empty string' do
      expect(described_class.encode_array([['key', '']])).to eq('key')
    end

    it 'return an encoded string given an array with a param equals empty object' do
      expect(described_class.encode_array([['key', {}]])).to eq('key')
    end

    it 'return an encoded string given an array with a param equals nil' do
      expect(described_class.encode_array([['key', nil]])).to eq('key')
    end

    it 'return an encoded string given an array with multiple params' do
      expect(described_class.encode_array([%w[key1 value1], %w[key2 value2], %w[key3 value3]]))
        .to eq('key1=value1&key2=value2&key3=value3')
    end

    it 'return an encoded string given an array with a param of array' do
      expect(described_class.encode_array([['key', %w[value1 value2 value3]]]))
        .to eq('key=value1&key=value2&key=value3')
    end
  end

  context 'split a query string to an array of param pairs' do
    it 'return an array given a query string with a param' do
      expect(described_class.split_query('key=value')).to eq([%w[key value]])
    end

    it 'return an array given a query string with multiple params' do
      expect(described_class.split_query('key1=value1&key2=value2&key3=value3'))
        .to eq([%w[key1 value1], %w[key2 value2], %w[key3 value3]])
    end

    it 'return an array given a query string with empty value' do
      expect(described_class.split_query('key1&key2=value2&key3=value3'))
        .to eq([%w[key1], %w[key2 value2], %w[key3 value3]])
    end

    it 'return an array given a query string with same key' do
      expect(described_class.split_query('key=value1&key=value2&key=value3'))
        .to eq([%w[key value1], %w[key value2], %w[key value3]])
    end
  end
end
