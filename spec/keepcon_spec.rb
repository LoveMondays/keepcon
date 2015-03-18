require 'spec_helper'

describe Keepcon do
  it 'has a version number' do
    expect(Keepcon::VERSION).not_to be nil
  end

  describe '.setup' do
    it 'passes the Keepcon module to the block' do
      described_class.setup do |config|
        expect(config).to eq(described_class)
      end
    end
  end
end
