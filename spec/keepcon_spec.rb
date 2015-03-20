require 'spec_helper'

describe Keepcon do
  it 'has a version number' do
    expect(Keepcon::VERSION).not_to be nil
  end

  describe '.add_context' do
    subject { described_class.add_context(:user_name, params) }

    let(:params) { { user: 'UserName', password: 'password' } }
    let(:added_context) { described_class.contexts[:user_name] }

    before { subject }

    it { expect(described_class.contexts.length).to eq(1) }
    it { expect(added_context.user).to eq(params[:user]) }
  end

  describe '.setup' do
    it 'passes the Keepcon module to the block' do
      described_class.setup do |config|
        expect(config).to eq(described_class)
      end
    end
  end
end
