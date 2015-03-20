require 'spec_helper'

describe Keepcon::Rails do
  describe '.setup!' do
    before do
      ActiveRecord = Class.new
      ActiveRecord::Base = Class.new(ActiveRecord)
    end

    it 'includes Integration on ActiveModel::Model' do
      expect(ActiveRecord::Base.include?(Keepcon::Integration)).to be false
      described_class.setup!
      expect(ActiveRecord::Base.include?(Keepcon::Integration)).to be true
    end
  end
end
