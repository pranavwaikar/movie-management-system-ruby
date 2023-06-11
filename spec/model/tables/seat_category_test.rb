# frozen_string_literal: true

require './src/model/tables/seat_category'

RSpec.describe SeatCategory do
  subject { SeatCategory.new }

  describe '#create' do
    it 'Should be create the seat category entry' do
      expect(subject.create('foo', 100)).to eq({ id: 1, seat_category: 'foo', price: 100 })
    end
  end
end
