require 'spec_helper'

describe Keepcon::Integration do
  subject { instance }

  let(:dummy_class) do
    Class.new do
      include Keepcon::Integration

      define_method(:id) { 1 }
      define_method(:a) { 1 }
    end
  end
  let(:instance) { dummy_class.new }
  let(:added_context) { Keepcon.contexts[:user] }

  before { Keepcon.add_context(:user, user: 'user', password: 'password') }

  describe '.keepcon_integration' do
    context 'when context do not exists' do
      subject { dummy_class.keepcon_integration(:test) }

      it { expect { subject }.to raise_error }
    end

    context 'when context exists' do
      subject { dummy_class.keepcon_integration(:user, a: :b) }

      before { subject }

      it { expect(added_context.translate(:a)).to eq(:b) }
    end
  end

  context 'with some integration defined' do
    before { dummy_class.keepcon_integration(:user, a: :b) }

    describe '#send_to_keepcon' do
      subject { instance.send_to_keepcon }

      it 'calls send_data on the entity' do
        expect(instance.keepcon_entity).to receive(:send_data).once
        subject
      end
    end

    describe '#keepcon_entity' do
      subject { instance.keepcon_entity }

      it { expect(subject.context).to eq(added_context) }
      it { expect(subject.instance).to eq(instance) }
    end
  end
end
