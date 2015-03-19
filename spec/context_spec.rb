require 'spec_helper'

describe Keepcon::Context do
  describe '#new' do
    subject { described_class.new(attributes) }

    let(:attributes) { attributes_for(:context, mappings: { a: :b }) }

    it { expect(subject.user).to eq(attributes[:user]) }
    it { expect(subject.translate(:a)).to eq(:b) }
  end

  describe '#map & #translate' do
    let(:attributes) { { a: :b, c: :d } }

    before { subject.map(attributes) }

    it { expect(subject.translate(:a)).to eq(:b) }
    it { expect(subject.translate(:c)).to eq(:d) }
  end

  describe '#attribute_names' do
    subject { context.attribute_names }

    let(:context) { build(:context, mappings: { a: :b, c: :d }) }

    it { expect(subject).to match_array([:a, :c]) }
  end
end
