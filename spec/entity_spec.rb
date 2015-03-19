require 'spec_helper'

describe Keepcon::Entity do
  let(:dummy_class) do
    Class.new do
      define_method(:id) { 1 }
      define_method(:a) { 1 }
      define_method(:b) { 2 }
      define_method(:created_at) { Time.utc('2015-01-01') }
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
    let(:instance) { dummy_class.new }

    context 'when the attribute is mapped to author' do
      let(:context) { build(:context, mappings: { a: :author }) }

      it 'generates the correct xml' do
        is_expected.to eq(<<-"END".gsub(/(\s*\n|^\s*)/, '').strip)
          <import>
            <contenttype>#{context.name}</contenttype>
            <contents>
              <content id="1">
                <author type="author">1</author>
              </content>
            </contents>
          </import>
        END
      end
    end

    context 'when the attribute is mapped to datetime' do
      let(:context) { build(:context, mappings: { created_at: :datetime }) }

      it 'generates the correct xml' do
        is_expected.to eq(<<-"END".gsub(/(\s*\n|^\s*)/, '').strip)
          <import>
            <contenttype>#{context.name}</contenttype>
            <contents>
              <content id="1">
                <datetime>1420070400000</datetime>
              </content>
            </contents>
          </import>
        END
      end
    end

    context 'with other mappings' do
      let(:context) { build(:context, mappings: { a: :x, b: :y }) }

      it 'generates the correct xml' do
        is_expected.to eq(<<-"END".gsub(/(\s*\n|^\s*)/, '').strip)
          <import>
            <contenttype>#{context.name}</contenttype>
            <contents>
              <content id="1">
                <x><![CDATA[1]]></x>
                <y><![CDATA[2]]></y>
              </content>
            </contents>
          </import>
        END
      end
    end
  end
end
