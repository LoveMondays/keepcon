require 'spec_helper'

describe Keepcon::Rails do
  describe '.setup!' do
    before do
      ActiveModel = Class.new
      ActiveModel::Model = Class.new(ActiveModel)
    end

    it 'includes Integration on ActiveModel::Model' do
      expect(ActiveModel::Model.include?(Keepcon::Integration)).to be false
      described_class.setup!
      expect(ActiveModel::Model.include?(Keepcon::Integration)).to be true
    end
  end
end
