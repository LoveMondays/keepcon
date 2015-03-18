require 'spec_helper'

describe Keepcon::Entity do
  let(:dummy_class) do
    Class.new do
      define_method(:id) { 1 }
      define_method(:a) { 1 }
      define_method(:b) { 2 }
    end
  end

  describe '#new' do
    subject { described_class.new(attributes) }

    let(:context) { build(:context) }
    let(:instance) { Object.new }
    let(:attributes) do
      attributes_for(:entity, context: context, instance: instance)
    end

    it { expect(subject.context).to eq(attributes[:context]) }
    it { expect(subject.instance).to eq(attributes[:instance]) }
  end

  describe '#translate' do
    subject { entity.translate }

    let(:entity) { build(:entity, context: context, instance: instance) }
    let(:context) { build(:context, mappings: { a: :x, b: :y }) }
    let(:instance) { dummy_class.new }

    it { expect(subject).to match_array(x: 1, y: 2) }
    it { expect(subject.class).to eq(Hash) }
  end

  describe '#to_xml' do
    subject { entity.to_xml }

    let(:entity) { build(:entity, context: context, instance: instance) }
    let(:context) { build(:context, mappings: { a: :x, b: :y }) }
    let(:instance) { dummy_class.new }

    it 'generates the correct xml' do
      is_expected.to eq(<<-"END".gsub(/(\s*\n|^\s*)/, '').strip)
        <import>
          <contenttype>#{context.name}</contenttype>
          <contents>
            <content id="1">
              <x>1</x>
              <y>2</y>
            </content>
          </contents>
        </import>
      END
    end
  end
end
