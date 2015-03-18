require 'spec_helper'

describe Keepcon::Context do
  describe '#new' do
    subject { described_class.new(attributes) }

    let(:attributes) { attributes_for(:context) }

    it { expect(subject.name).to eq(attributes[:name]) }
    it { expect(subject.password).to eq(attributes[:password]) }
  end
end
