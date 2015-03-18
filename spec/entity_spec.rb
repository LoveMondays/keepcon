require 'spec_helper'

describe Keepcon::Entity do
  describe '#new' do
    subject { described_class.new(attributes) }

    let(:attributes) { attributes_for(:entity, context: context, instance: instance) }
    let(:context) { build(:context) }
    let(:instance) { Object.new }

    it { expect(subject.context).to eq(attributes[:context]) }
    it { expect(subject.instance).to eq(attributes[:instance]) }
  end
end
