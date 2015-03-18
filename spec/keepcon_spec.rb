require 'spec_helper'

describe Keepcon do
  it 'has a version number' do
    expect(Keepcon::VERSION).not_to be nil
  end

  describe '.add_context' do
    subject { described_class.add_context(params) }

    let(:params) { { name: 'test', password: 'password' } }
    let(:added_context) { described_class.contexts.last }

    before { subject }

    it { expect(described_class.contexts.length).to eq(1) }
    it { expect(added_context.name).to eq(params[:name]) }
    it { expect(added_context.password).to eq(params[:password]) }
  end

  describe '.setup' do
    it 'passes the Keepcon module to the block' do
      described_class.setup do |config|
        expect(config).to eq(described_class)
      end
    end
  end
end
