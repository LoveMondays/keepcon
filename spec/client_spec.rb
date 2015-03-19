require 'spec_helper'

describe Keepcon::Client do
  describe '#new' do
    it 'passes the self to the block' do
      described_class.new do |config|
        expect(config.class).to eq(described_class)
      end
    end
  end
end
