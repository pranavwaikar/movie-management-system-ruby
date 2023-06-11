# frozen_string_literal: true

require './src/model/tables/screen'

RSpec.describe Screen do
  subject { Screen.new }

  describe '#create' do
    it 'Should be create the screens entry' do
      expect(subject.create('foo')).to eq({ id: 1, name: 'foo' })
    end
  end
end
