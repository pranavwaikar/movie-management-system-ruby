# frozen_string_literal: true

require './src/controller/seats_controller'
require './src/model/database/database'

RSpec.describe SeatsController do
  before(:all) do
    Database.seed
  end

  after(:all) do
    Database.truncate
  end

  subject { SeatsController.new }

  describe '#get_seat_by_name' do
    it 'Should get the seat if exists' do
      expect(subject.get_seat_by_name('A1',
                                      1)).to eq({ id: 1, name: 'A1', screen_id: 1, seat_category_id: 1 })
    end

    it 'Should get nil if seat does not exists' do
      expect(subject.get_seat_by_name('Z1', 1)).to eq(nil)
    end
  end

  describe '#get_seat_price' do
    it 'Should get the seat price if exists' do
      expect(subject.get_seat_price(1)).to eq(320)
    end

    it 'Should get nil if seat does not exists' do
      expect(subject.get_seat_price(200)).to eq(-1)
    end
  end
end
