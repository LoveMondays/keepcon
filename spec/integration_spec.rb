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
  let(:added_context) { Keepcon.contexts[:context] }

  before { Keepcon.add_context(:context, user: 'user', password: 'password') }

  describe '.keepcon_integration' do
    context 'when context do not exists' do
      subject { dummy_class.keepcon_integration(:missing_context) }

      it { expect { subject }.to raise_error }
    end

    context 'when context exists' do
      subject { dummy_class.keepcon_integration(:context, a: :b) }

      before { subject }

      it { expect(added_context.translate(:a)).to eq(:b) }
      it { expect(instance.respond_to?(:send_context_to_keepcon)).to be true }
    end
  end

  context 'with some integration defined' do
    before { dummy_class.keepcon_integration(:context, a: :b) }

    describe '#send_to_keepcon' do
      subject { instance.send_to_keepcon(added_context, mode) }

      let(:entity) do
        Keepcon::Entity.new(context: added_context, instance: instance)
      end

      before { allow(instance).to receive(:keepcon_entity).and_return(entity) }

      context 'sync request' do
        let(:mode) { :sync }

        it 'calls send_data on the entity' do
          expect(entity).to receive(:send_data).with(:sync).once
          subject
        end
      end

      context 'async request' do
        let(:mode) { :async }

        it 'calls send_data on the entity' do
          expect(entity).to receive(:send_data).with(:async).once
          subject
        end
      end
    end

    describe '#keepcon_entity' do
      subject { instance.keepcon_entity(added_context) }

      it { expect(subject.context).to eq(added_context) }
      it { expect(subject.instance).to eq(instance) }
    end

    describe '#send_context_to_keepcon' do
      subject { instance.send_context_to_keepcon(mode) }

      context 'sync request' do
        let(:mode) { :sync }

        it 'calls #send_to_keepcon with the context' do
          expect(instance).to receive(:send_to_keepcon)
            .with(added_context, :sync)
          subject
        end
      end

      context 'async request' do
        let(:mode) { :async }

        it 'calls #send_to_keepcon with the context' do
          expect(instance).to receive(:send_to_keepcon)
            .with(added_context, :async)
          subject
        end
      end
    end
  end

  describe '.fetch_keepcon_results' do
    subject { dummy_class.fetch_keepcon_results(context) }

    let(:results) { double status: 200, body: body }
    let(:body) do
      <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <export setId="b537-35642fb84114">
          <contents></contents>
        </export>
      XML
    end

    context 'when context do not exists' do
      let(:context) { :missing_context }

      it { expect { subject }.to raise_error }
    end

    context 'when context exists' do
      let(:context) { :context }
      let(:client) { added_context.client }

      it 'calls client async_results_request for that context' do
        expect(client).to receive(:async_results_request) { results }
        expect(client).to receive(:async_ack).with('b537-35642fb84114')
        is_expected.to be_a(Keepcon::Entity::Response)
      end
    end
  end
end
