require 'spec_helper'

describe Keepcon::Client do
  let(:client) do
    described_class.new do |config|
      config.user = 'user'
      config.password = 'password'
    end
  end

  describe '.new' do
    it 'passes the self to the block' do
      described_class.new do |config|
        expect(config.class).to eq(described_class)
      end
    end
  end

  describe '#content_request' do
    subject { client.content_request(data, mode) }

    let(:adapter) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.put('/synchronic/moderate', 'data', headers) do |_env|
          [200, {}, 'sync']
        end
        stub.put('/input/contentSet', 'data', headers) do |_env|
          [200, {}, 'async']
        end
      end
    end
    let(:headers) do
      {
        'User-Agent' => 'Keepcon Client API REST v1.0 - Context Name: [user]',
        'Authorization' => 'Basic dXNlcjpwYXNzd29yZA=='
      }
    end
    let!(:faraday) { Faraday.new { |f| f.adapter :test, adapter } }

    before do
      allow(Faraday).to receive(:new).and_return(faraday)
    end

    context 'with empty data' do
      let(:data) { '' }
      let(:mode) { :sync }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with any data' do
      let(:data) { 'data' }

      context 'sync request' do
        let(:mode) { :sync }

        it { expect(subject.status).to eq(200) }
        it { expect(subject.body).to eq('sync') }
      end

      context 'async request' do
        let(:mode) { :async }

        it { expect(subject.status).to eq(200) }
        it { expect(subject.body).to eq('async') }
      end
    end
  end

  describe '#async_results_request' do
    subject { client.async_results_request }

    let!(:faraday) { Faraday.new { |f| f.adapter :test, adapter } }
    let(:adapter) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        uri = '/output/contentSet?contextName=user&clientACK=true'
        stub.put(uri, '', headers) do |_env|
          [200, {}, 'all-results-body']
        end
      end
    end
    let(:headers) do
      {
        'User-Agent' => 'Keepcon Client API REST v1.0 - Context Name: [user]',
        'Authorization' => 'Basic dXNlcjpwYXNzd29yZA=='
      }
    end

    before do
      allow(Faraday).to receive(:new).and_return(faraday)
    end

    it { expect(subject.status).to eq(200) }
    it { expect(subject.body).to eq('all-results-body') }
  end
end
