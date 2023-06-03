# frozen_string_literal: true

require './sample'

describe Sample do
  describe '#add' do
    it 'always return 5' do
      expect(subject.add).to eq(5)
    end
  end
end
