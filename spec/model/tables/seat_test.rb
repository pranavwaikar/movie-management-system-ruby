# frozen_string_literal: true

require './src/model/tables/seat'

RSpec.describe Seat do
  subject { Seat.new }

  describe '#create' do
    it 'Should be create the seats entry' do
      expect(subject.create('A1', 1, 1)).to eq({ id: 1, name: 'A1', screen_id: 1, seat_category_id: 1 })
    end
  end
end
