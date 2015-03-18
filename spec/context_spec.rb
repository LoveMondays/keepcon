require 'spec_helper'

describe Keepcon::Context do
  describe '#new' do
    subject { described_class.new(attributes) }

    let(:attributes) { attributes_for(:context) }

    it { expect(subject.name).to eq(attributes[:name]) }
  end

  describe '#map & #translate' do
    let(:attributes) { { a: :b, c: :d } }

    before { subject.map(attributes) }

    it { expect(subject.translate(:a)).to eq(:b) }
    it { expect(subject.translate(:c)).to eq(:d) }
  end
end
