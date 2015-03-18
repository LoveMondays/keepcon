require 'spec_helper'

describe Keepcon::Mapping do
  describe '#new' do
    subject { described_class.new(attributes) }

    let(:attributes) { attributes_for(:mapping, from: :a, to: :b) }

    it { expect(subject.from).to eq(attributes[:from]) }
    it { expect(subject.to).to eq(attributes[:to]) }
  end
end
