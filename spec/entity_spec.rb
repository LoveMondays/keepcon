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

  describe '#translate' do
    subject { entity.translate }

    let(:dummy_class) do
      Class.new do
        define_method(:a) { 1 }
        define_method(:b) { 2 }
      end
    end

    let(:entity) { build(:entity, context: context, instance: instance) }
    let(:context) { build(:context, mappings: { a: :x, b: :y }) }
    let(:instance) { dummy_class.new }

    it { expect(subject).to match_array(x: 1, y: 2) }
    it { expect(subject.class).to eq(Hash) }
  end
end
