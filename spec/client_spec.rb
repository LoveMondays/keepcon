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
    subject { client.content_request(data) }

    let(:adapter) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.put('/synchronic/moderate', 'data', headers) do |_env|
          [200, {}, 'ok']
        end
      end
    end
    let(:headers) do
      { 'User-Agent' => 'Keepcon Client API REST v1.0 - Context Name: [user]' }
    end
    let!(:faraday) { Faraday.new { |f| f.adapter :test, adapter } }

    before do
      allow(Faraday).to receive(:new).and_return(faraday)
    end

    context 'with empty data' do
      let(:data) { '' }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with any data' do
      let(:data) { 'data' }

      it { expect(subject.status).to eq(200) }
      it { expect(subject.body).to eq('ok') }
    end
  end
end
